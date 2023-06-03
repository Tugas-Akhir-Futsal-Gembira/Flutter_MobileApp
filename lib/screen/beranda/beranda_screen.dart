import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/menunggu_pembayaran_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/sudah_dibayar_model.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/field_listview.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/tidak_punya_pemesanan_container.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/variables/variables.dart';
import 'package:flutter_application_futsal_gembira/widget/penyewaan_container.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {

  ValueNotifier<bool> isLoading = ValueNotifier(true);
  ValueNotifier<AbstractPenyewaanModel?> activeBooking = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBaseColor,
      child: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, value, child) {
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
        child: RefreshIndicator(
          onRefresh: () async{
            refresh();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  ///'Anda tidak punya pemesanan aktif' or PenyewaanContainer
                  // const TidakPunyaPemesananContainer(),
                  ValueListenableBuilder(
                    valueListenable: activeBooking, 
                    builder: (context, value, child) {

                      return (activeBooking.value is AbstractPenyewaanModel)
                          ? PenyewaanContainer(
                            abstractPenyewaanModel: activeBooking.value!,
                            transparentBackground: false,
                            customMessage: (activeBooking.value.runtimeType is SudahDibayarModel)
                                ? 'Semoga ${Variables.profileData!.name} mendapat pengalaman menyenangkan'
                                : 'Batas pembayaran hingga ${customDateFormat((activeBooking.value as MenungguPembayaranModel).paymentDueDateTime!)}',
                          )
                          : const TidakPunyaPemesananContainer();
                       
                    },
                  ),
                  
                  ///TEMP
                  ///Status pembayaran aktif terkini
                  PenyewaanContainer(
                    abstractPenyewaanModel: SudahDibayarModel(
                      fieldName: 'Lapangan#1', 
                      rentDateTime: DateTime.now().add(const Duration(hours: 2)), 
                      durationInt: 2, 
                      createdAtDateTime: DateTime.now(),
                    ),
                    customMessage: 'Semoga Chandra mendapat pengalaman menyenangkan',
                    transparentBackground: false,
                  ),
                  const SizedBox(height: 16,),
                  const FieldListView(),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  void refresh() async{
    isLoading.value = true;
    
    ///[
    ///   jsonActiveBooking
    ///]
    List<JSONModel> list = await Future.wait([
      GateService.getActiveBookingUser()
    ]);

    JSONModel jsonActiveBooking = list[0];
    print(jsonActiveBooking.toString1());

    ///If no activeBooking, return null
    ///Else return to child class of AbstractPenyewaanModel 
    activeBooking.value = (jsonActiveBooking.data == null)
        ? null
        : AbstractPenyewaanModel.fromJSON(jsonActiveBooking.data!);
    
    print(activeBooking.value);

    

    isLoading.value = false;
    // Timer( 
    //   const Duration(seconds: 1), 
    //   ()=> isLoading.value = false,
    // );
  }
}