import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/field/field_model.dart';
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
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/penyewaan_container.dart';

class BerandaScreen extends StatefulWidget {
  const BerandaScreen({super.key});

  @override
  State<BerandaScreen> createState() => _BerandaScreenState();
}

class _BerandaScreenState extends State<BerandaScreen> {

  ValueNotifier<bool> isLoadingValueNotifier = ValueNotifier(true);
  ValueNotifier<AbstractPenyewaanModel?> activeBookingValueNotifier = ValueNotifier(null);
  ValueNotifier<List<FieldModel>?> listFieldValueNotifier = ValueNotifier(null);
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    super.initState();
    refresh();

    ///Refresh when receive notification
    streamSubscription = FirebaseMessaging.onMessage.listen((event) {
      refresh();
    });
  }

  @override
  void dispose() async{
    super.dispose();
    await streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBaseColor,
      child: ValueListenableBuilder(
        valueListenable: isLoadingValueNotifier,
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
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                  
                    ///'Anda tidak punya pemesanan aktif' or PenyewaanContainer
                    ValueListenableBuilder(
                      valueListenable: activeBookingValueNotifier, 
                      builder: (context, value, child) {
                        
                        ///If activeBooking value is subclass of AbstractPenyewaanModel, return PenyewaanContainer
                        ///Else (must be null) return TidakPunyaPemesananContainer
                        return (activeBookingValueNotifier.value is AbstractPenyewaanModel)
                            ? PenyewaanContainer(
                              abstractPenyewaanModel: activeBookingValueNotifier.value!,
                              transparentBackground: false,
                              customMessage: (activeBookingValueNotifier.value.runtimeType == SudahDibayarModel)
                                  ? 'Semoga ${Variables.profileData!.name} mendapat pengalaman menyenangkan'
                                  : 'Batas pembayaran hingga ${customDateFormat((activeBookingValueNotifier.value as MenungguPembayaranModel).paymentDueDateTime!)}',
                            )
                            : const TidakPunyaPemesananContainer();
                         
                      },
                    ),
                    const SizedBox(height: 16,),
                  
                    ///List of Field
                    ValueListenableBuilder(
                      valueListenable: listFieldValueNotifier,
                      builder: (context, value, child) {
                        return FieldListView(listField: listFieldValueNotifier.value,);
                      }
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }

  Future<void> refresh() async{
    isLoadingValueNotifier.value = true;
    
    ///[
    ///   jsonActiveBooking,
    ///   jsonListFields,
    ///]
    List<JSONModel> list = await Future.wait([
      GateService.getActiveBookingUser(),
      GateService.getListFields()
    ]);

    JSONModel jsonActiveBooking = list[0];
    JSONModel jsonListFields = list[1];

    if(jsonActiveBooking.statusCode == 200 && jsonListFields.statusCode == 200){

      ///If no activeBooking, return null
      ///Else return to child class of AbstractPenyewaanModel 
      activeBookingValueNotifier.value = (jsonActiveBooking.data == null)
          ? null
          : AbstractPenyewaanModel.fromJSON(jsonActiveBooking.data!);

      ///If no listField, return null
      ///Else return to list of FieldModel
      listFieldValueNotifier.value = (jsonListFields.data == null)
          ? null
          : (jsonListFields.data as List).map((e){
            return FieldModel.fromJSONListField(e as Map<String, dynamic>);
          }).toList();
    }
    else if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(

        ///Show error of listFields if activeBooking statusCode is 200
        ///Else show error of activeBooking
        CustomSnackbar(
          title: (jsonActiveBooking.statusCode == 200) 
              ? jsonListFields.getErrorToString() 
              : jsonActiveBooking.getErrorToString(),
          color: error2Color,
        )
      );
    }
        
    isLoadingValueNotifier.value = false;
  }
}