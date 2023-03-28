import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/sudah_dibayar_model.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/field_gridview.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/welcome_container.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/widget/penyewaan_container.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {

  ValueNotifier<bool> isLoading = ValueNotifier(true);

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
            return LinearProgressIndicator(
              color: infoColor,
              backgroundColor: primaryLightestColor,
            );
          }
          else{
            return child!;
          }
        },
        child: Column(
          children: [
            Container(
              height: 1,
              color: primaryLightestColor,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async{
                  refresh();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // WelcomeContainer(name: 'Chandra',),
                        PenyewaanContainer(
                          abstractPenyewaanModel: SudahDibayarModel(
                            fieldName: 'Lapangan#1', 
                            rentDateTime: DateTime.now().add(const Duration(hours: 2)), 
                            durationInt: 2, 
                            createdAtDateTime: DateTime.now(),
                          ),
                          customMessage: 'Semoga Chandra mendapat pengalaman menyenangkan',
                        ),
                        const SizedBox(height: 16,),
                        const FieldGridView(name: 'Chandra'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  void refresh(){
    isLoading.value = true;

    Timer( 
      const Duration(seconds: 1), 
      ()=> isLoading.value = false,
    );
  }
}