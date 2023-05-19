import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/menunggu_pembayaran.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/sudah_dibayar_model.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/penyewaan_container.dart';
import 'package:flutter_application_futsal_gembira/widget/penyewaan_container_2.dart';

class RiwayatPenyewaanScreen extends StatefulWidget {
  const RiwayatPenyewaanScreen({super.key});

  @override
  State<RiwayatPenyewaanScreen> createState() => _RiwayatPenyewaanScreenState();
}

class _RiwayatPenyewaanScreenState extends State<RiwayatPenyewaanScreen> {

  ValueNotifier<bool> isLoading = ValueNotifier(true);
  List<AbstractPenyewaanModel> listPenyewaanModel = [];

  @override
  void initState() {
    ///After 1 second, from loading linear transformed to riwayat penyewaan screen
    super.initState();
    refreshDummy();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isLoading,
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
          const Center(
            child: Text(
              'Riwayat anda kosong\nSeperti rasanya ditinggal doi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: regular,
                fontSize: 16,
                color: primaryLightestColor,
              ),
            ),
          ) : 

          ///If list is not empty
          RefreshIndicator(
            onRefresh: () async{
              refreshDummy();
            },
            child: ListView.builder(
              itemCount: listPenyewaanModel.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) =>  PenyewaanContainer2(abstractPenyewaanModel: listPenyewaanModel[index])
            ),
          ),
    );
  }

  void refreshDummy(){
    isLoading.value = true;

    ///Add list dummy
      listPenyewaanModel = [
        SudahDibayarModel(
          fieldName: "Lapangan #1", 
          rentDateTime: DateTime.now().add(const Duration(hours: 2)), 
          durationInt: 2, 
          createdAtDateTime: DateTime(2023, 9, 23, 22, 45),
        ),

        MenungguPembayaranModel(
          fieldName: "Lapangan #1", 
          rentDateTime: DateTime.now().add(const Duration(hours: 2)), 
          durationInt: 2, 
          createdAtDateTime: DateTime(2023, 9, 23, 22, 45),
        )
      ];

    Timer(
      const Duration(seconds: 1), 
      ()=> isLoading.value = false,
    );
  }
}