import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/biaya_sewa/biaya_sewa_model.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/screen/detail_penyewaan/widget/status_penyewaan.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/widget/biaya_sewa.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPenyewaanScreen extends StatefulWidget {
  const DetailPenyewaanScreen({super.key, required this.bookingId});
  
  final int bookingId;

  @override
  State<DetailPenyewaanScreen> createState() => _DetailPenyewaanScreenState();
}

class _DetailPenyewaanScreenState extends State<DetailPenyewaanScreen> {

  ValueNotifier<bool> isLoading = ValueNotifier(true);
  ScrollController fieldScrollController = ScrollController();
  AbstractPenyewaanModel? abstractPenyewaanModel;
  BiayaSewaModel? biayaSewaModel;
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

    ScrollController scrollController = ScrollController();
    ValueNotifier<double> opacity = ValueNotifier(0);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/football doodle.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0xFA2F2F2F), BlendMode.srcATop)
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,

        ///AppBar
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 71,
          titleSpacing: 20,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context, true);
            }, 
            icon: SvgPicture.asset('assets/icon/Caret-Left.svg')
          ),
          title: const Text(
            'Detail Penyewaan',
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 20,
            ),
          ),
          flexibleSpace: Column(
            children: [
              Container(
                color: primaryBaseColor,
                width: double.infinity,
                child: const SafeArea(child: SizedBox(),),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: opacity,
                  builder: (context, value, child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryBaseColor,
                            primaryBaseColor.withOpacity(opacity.value)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),

        body: WillPopScope(
          onWillPop: () async{
            Navigator.pop(context, true);
            return false;
          },
          child: RefreshIndicator(
            onRefresh: () async{
              refresh();
            },
            child: NotificationListener<ScrollUpdateNotification>(
              onNotification: (notification) {
                if(scrollController.offset < 71){
                  opacity.value = scrollController.offset / 71;
                  return true;
                }
                else{
                  opacity.value = 1;
                  return true;
                }
              },
              child: SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    children: [
                            
                      ///Image with field name, booking time date, booking duration
                      Stack(
                        children: [
                            
                          ///Image
                          AspectRatio(
                            aspectRatio: 428/302,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const AssetImage('assets/image/Lapangan futsal wallpaper.jpg'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.7), 
                                    BlendMode.srcATop
                                  ),
                                )
                              ),
                            ),
                          ),
                            
                          ///Bunch of Data Text
                          Positioned.fill(
                            child: Container(
                              // color: Colors.amber,
                              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                              ///For dividing notch(and System UI) and content(such as 'Lapangan #1', 'Tanggal & Waktu Sewa')
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).viewPadding.top + 71, //notch and systemUI + AppBar height
                                  ),
                                  Expanded(
                                    child: ValueListenableBuilder(
                                      valueListenable: isLoading,
                                      builder: (context, value, child) {
                                        
                                        (isLoading.value == true)
                                            ? null
                                            : Future.delayed( const Duration(milliseconds: 0),() {
                                              if(fieldScrollController.hasClients){
                                                fieldScrollController.animateTo(
                                                  18, 
                                                  duration: const Duration(seconds: 2), 
                                                  curve: Curves.easeOutCubic
                                                );
                                              }
                                            },);
                            
                                        return (isLoading.value == true)
                                            ? const SizedBox()
                                            : SizedBox(
                                              width: double.infinity,
                                              ///Bunch of field data
                                              child: LayoutBuilder(
                                                builder: (p0context1, p1constraint1) {
                                                  return SingleChildScrollView(
                                                    controller: fieldScrollController,
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        minHeight: p1constraint1.maxHeight
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(height: 18,),
                            
                                                          ///'Lapangan #1'
                                                          Text(
                                                            abstractPenyewaanModel!.fieldName,
                                                            style: const TextStyle(
                                                              fontWeight: semiBold,
                                                              fontSize: 24,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 28,),
                            
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text(
                                                                      'Tanggal & Waktu Sewa',
                                                                      style: TextStyle(
                                                                        fontWeight: regular,
                                                                        fontSize: 14
                                                                      ),
                                                                    ),
                                                                    ///21 Januari 2023, 08:00
                                                                    Text(
                                                                      customDateFormat(abstractPenyewaanModel!.rentDateTime),
                                                                      style: const TextStyle(
                                                                        fontWeight: semiBold,
                                                                        fontSize: 16
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              const SizedBox(width: 32,),
                            
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    const Text(
                                                                      'Durasi Sewa',
                                                                      style: TextStyle(
                                                                        fontWeight: regular,
                                                                        fontSize: 14
                                                                      ),
                                                                    ),
                                                                    ///2 jam
                                                                    Text(
                                                                      '${abstractPenyewaanModel!.durationInt} jam',
                                                                      style: const TextStyle(
                                                                        fontWeight: semiBold,
                                                                        fontSize: 16
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )                                  
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }
                                              ),
                                            );
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                            
                        ],
                      ),///End of Image and Bunch of Field Data,
                            
                      ///Status and Biaya Sewa
                      ValueListenableBuilder(
                        valueListenable: isLoading,
                        builder: (context, value, child) {
                          
                          return (isLoading.value == true)
                              ? const LinearProgressIndicator(
                                color: infoColor,
                                backgroundColor: primaryLightestColor,
                              )
                              : Padding(
                                padding: const EdgeInsets.all(16), 
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                            
                                    ///Status
                                    const Text(
                                      'Status',
                                      style: TextStyle(
                                        fontWeight: semiBold,
                                        fontSize: 16
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                            
                                    StatusPenyewaan(model: abstractPenyewaanModel!, totalPrice: biayaSewaModel!.totalPrice!),
                            
                            
                                    const SizedBox(height: 16,),
                            
                                    ///Biaya Sewa
                                    const Text(
                                      'Biaya Sewa',
                                      style: TextStyle(
                                        fontWeight: semiBold,
                                        fontSize: 16
                                      ),
                                    ),
                                    const SizedBox(height: 4,),
                            
                                    BiayaSewa(
                                      fieldDayPrice: biayaSewaModel!.dayPrice,
                                      fieldNightPrice: biayaSewaModel!.nightPrice,
                                      durationNight: biayaSewaModel!.nightPriceQuantity,
                                      durationDay: biayaSewaModel!.dayPriceQuantity,
                                      adminPriceNominal: biayaSewaModel!.adminPrice,
                                      totalPrice: biayaSewaModel!.totalPrice,
                                    )
                                  ],
                                ),
                              );
                        }
                      )
                    ],
                  )
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  Future<void> refresh() async{
    isLoading.value = true;

    JSONModel json = await GateService.getDetailBookingUser(bookingId: widget.bookingId);
    
    if(json.statusCode == 200){
      abstractPenyewaanModel = AbstractPenyewaanModel.fromJSON(json.data, bookingId: widget.bookingId);
      biayaSewaModel = BiayaSewaModel.fromJSON(json.data);
    }
    else if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(title: json.getErrorToString(), color: error2Color,)
      );
      Navigator.pop(context);
    }

    isLoading.value = false;
  }
}