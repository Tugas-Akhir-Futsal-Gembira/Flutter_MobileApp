import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/menunggu_pembayaran_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/sudah_dibayar_model.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/penyewaan_container.dart';

class RiwayatPenyewaanScreen extends StatefulWidget {
  const RiwayatPenyewaanScreen({super.key});

  @override
  State<RiwayatPenyewaanScreen> createState() => _RiwayatPenyewaanScreenState();
}

class _RiwayatPenyewaanScreenState extends State<RiwayatPenyewaanScreen> {

  ValueNotifier<bool> isLoadingValueNotifier = ValueNotifier(true);
  List<AbstractPenyewaanModel> listPenyewaanModel = [];

  @override
  void initState() {
    ///After 1 second, from loading linear transformed to riwayat penyewaan screen
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoadingValueNotifier,
      builder: (context, value, child){
        if(value){
          return const LinearProgressIndicator(
            color: infoColor,
            backgroundColor: primaryLightestColor,
          );
        }
        else{
          return child!;
        }
      },
      child: (listPenyewaanModel.isEmpty) ? 

          ///If list is empty
          RefreshIndicator(
            onRefresh: () async{
              refresh();
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
              refresh();
            },
            child: ListView.builder(
              itemCount: listPenyewaanModel.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) =>  PenyewaanContainer(
                abstractPenyewaanModel: listPenyewaanModel[index],
                transparentBackground: true,
              )
            ),
          ),
    );
  }

  Future<void> refresh() async{
    isLoadingValueNotifier.value = true;

    ///Add list dummy
    listPenyewaanModel = [
      SudahDibayarModel(
        id: 0,
        fieldName: "Lapangan #1", 
        rentDateTime: DateTime.now().add(const Duration(hours: 2)), 
        durationInt: 2, 
        createdAtDateTime: DateTime(2023, 9, 23, 22, 45),
      ),

      MenungguPembayaranModel(
        id: 0,
        fieldName: "Lapangan #1", 
        rentDateTime: DateTime.now().add(const Duration(hours: 2)), 
        durationInt: 2, 
        createdAtDateTime: DateTime(2023, 9, 23, 22, 45),
      )
    ];
    
    JSONModel json = await GateService.getRiwayatBookingUser();
    
    if(json.statusCode == 200){
      listPenyewaanModel = (json.data['item'] as List).map((e) {
        return AbstractPenyewaanModel.fromJSON(e as Map<String, dynamic>);
      }).toList();
      print(json.data['item']);
      print((json.data['item'] as List).length);
    }

 
    isLoadingValueNotifier.value = false;
  }
}