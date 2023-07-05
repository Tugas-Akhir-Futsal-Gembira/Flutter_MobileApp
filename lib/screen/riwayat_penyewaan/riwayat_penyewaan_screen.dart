import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/screen/riwayat_penyewaan/widget/filter_riwayat.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/penyewaan_container.dart';

class RiwayatPenyewaanScreen extends StatefulWidget {
  const RiwayatPenyewaanScreen({super.key});

  @override
  State<RiwayatPenyewaanScreen> createState() => _RiwayatPenyewaanScreenState();
}

class _RiwayatPenyewaanScreenState extends State<RiwayatPenyewaanScreen> {

  ValueNotifier<bool> isLoadingValueNotifier = ValueNotifier(true);
  ValueNotifier<int> riwayatPageValueNotifier = ValueNotifier(1);
  bool riwayatExtendable = false;
  List<AbstractPenyewaanModel> listPenyewaanModel = [];
  StreamSubscription? streamSubscription;
  ///'week', 'month', 'year'
  String filter = 'week';

  @override
  void initState() {
    ///After 1 second, from loading linear transformed to riwayat penyewaan screen
    super.initState();
    refresh(value: filter);

    ///Refresh when receive notification
    streamSubscription = FirebaseMessaging.onMessage.listen((event) {
      refresh(value: filter);
    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Custom Chips in row
        FilterRiwayat(
          onTap: (value) {
            if(value == 0){
              filter = 'week';
            }
            else if(value == 1){
              filter = 'month';
            }
            else if(value == 2){
              filter = 'year';
            }
            refresh(value: filter);
          },
        ),

        ///Riwayat Penyewaan scrollview
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: isLoadingValueNotifier,
            builder: (context, value, child){
              if(value){
                return const Align(
                  alignment: Alignment.topCenter,
                  child: LinearProgressIndicator(
                    color: infoColor,
                    backgroundColor: primaryLightestColor,
                  ),
                );
              }
              else{
                return child!;
              }
            },
            child: Builder(
              builder: (context) {
                return (listPenyewaanModel.isEmpty) ? 
        
                    ///If list is empty
                    RefreshIndicator(
                      onRefresh: () async{
                        refresh(value: filter);
                      },
                      child: LayoutBuilder(
                        builder: (p0context, p1constraint) {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Container(
                              constraints: BoxConstraints(minHeight: p1constraint.maxHeight),
                              alignment: Alignment.center,
                              child: const Text(
                                'Riwayat anda kosong\nSeperti rasanya ditinggal doi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: regular,
                                  fontSize: 16,
                                  color: primaryLightestColor,
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ) : 
        
                    ///If list is not empty
                    RefreshIndicator(
                      onRefresh: () async{
                        refresh(value: filter);
                      },
                      child: ValueListenableBuilder(
                        valueListenable: riwayatPageValueNotifier,
                        builder: (context, value, child) {
                      
                          return ListView.builder(
                            itemCount: listPenyewaanModel.length + ((riwayatExtendable) ? 1 : 0),
                            padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                            itemBuilder: (context, index) {
                              
                              if(index < listPenyewaanModel.length){
                                return  PenyewaanContainer(
                                  abstractPenyewaanModel: listPenyewaanModel[index],
                                  transparentBackground: true,
                                );
                              }
                              else{
                      
                                extendListView();
                      
                                return const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: infoColor,
                                    color: Colors.white,
                                  ),
                                );
                              }
                            }
                          );
                        }
                      ),
                    );
              }
            ),
          ),
        ),
      ],
    );
  }

  ///Refresh screen
  ///
  ///value input: 'week', 'month', or 'year'
  Future<void> refresh({required String value}) async{
    isLoadingValueNotifier.value = true;
    
    JSONModel json = await GateService.getRiwayatBookingUser(filter: filter, page: 1);

    ///If statusCode = 200, add the data to listPenyewaanModel,
    ///clear list, reset riwayatExtendable to false, resetPageValueNotifier to 1,
    ///and findout if the list is extendable
    if(json.statusCode == 200){

      riwayatExtendable = false;
      riwayatPageValueNotifier.value = 1;

      listPenyewaanModel.clear();
      List<AbstractPenyewaanModel> tempListPenyewaanModel = (json.data['item'] as List).map((e) {
        return AbstractPenyewaanModel.fromJSON(e as Map<String, dynamic>);
      }).toList();
      listPenyewaanModel.addAll(tempListPenyewaanModel);

      // riwayatExtendable = (json.data['total_item'] * int.parse(json.data['current_page']) < json.data['total_all_item'])
      //     ? true : false;
      riwayatExtendable = (json.data['total_item'] * json.data['current_page'] < json.data['total_all_item'])
          ? true : false;
    }
    else if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(title: json.getErrorToString(), color: error2Color,)
      );
    }

    isLoadingValueNotifier.value = false;
  }

  ///Extend the listView
  Future<void> extendListView() async{
    JSONModel json = await GateService.getRiwayatBookingUser(filter: filter, page: riwayatPageValueNotifier.value + 1);

    if(json.statusCode == 200){
      List<AbstractPenyewaanModel> tempListPenyewaanModel = (json.data['item'] as List).map((e) {
        return AbstractPenyewaanModel.fromJSON(e as Map<String, dynamic>);
      }).toList();
      listPenyewaanModel.addAll(tempListPenyewaanModel);

      /// jika jumlah maximum item per page (5) x lembar sekarang < total jumlah item
      /// riwayat extendable = true
      /// Contoh1:  Sekarang lembar 2, maximum item per page 5,
      ///           Teorinya ada 10 item yang sudah di dapatkan
      ///           Total Jumlah item contohnya ada 17
      ///           Maka jika 5 x 2 < 17 -> riwayatExtendable = true(dapat menarik data lebih banyak)
      /// Contoh2:  Sekarang lembar 4, maximum item per page 5,
      ///           Teorinya ada 20 item yang sudah di dapatkan
      ///           Total jumlah item contohnya ada 17
      ///           Maka jika 5 x 4 < 17 -> riwayatExtendable = false(tidak dapat menarik data lebih banyak)
      // riwayatExtendable = (5 * int.parse(json.data['current_page']) < json.data['total_all_item'])
      //     ? true : false;
      riwayatExtendable = (5 * json.data['current_page'] < json.data['total_all_item'])
          ? true : false;
      riwayatPageValueNotifier.value += 1;
    }
    else if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(title: json.getErrorToString(), color: warningColor,)
      );
    }
  }
}