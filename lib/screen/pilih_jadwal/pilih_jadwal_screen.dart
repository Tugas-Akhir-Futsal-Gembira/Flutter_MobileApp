import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/field/field_model.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/payment_method/payment_methods_model.dart';
import 'package:flutter_application_futsal_gembira/screen/detail_penyewaan/detail_penyewaan_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/main_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/time_choosen_notifier.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/pilih_waktu.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/show_metode_pembayaran.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/variables/variables.dart';
import 'package:flutter_application_futsal_gembira/widget/biaya_sewa.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PilihJadwalScreen extends StatefulWidget {
  const PilihJadwalScreen({super.key, required this.fieldModel});

  final FieldModel fieldModel;

  @override
  State<PilihJadwalScreen> createState() => _PilihJadwalScreenState();
}

class _PilihJadwalScreenState extends State<PilihJadwalScreen> {

  ScrollController fieldScrollController = ScrollController();
  TextEditingController jadwalPenyewaanTextController = TextEditingController();
  ///ValueNotifier for JadwalPenyewaan
  ValueNotifier<DateTime?> dateChoosen = ValueNotifier(null);
  ///ValueNotifier for MetodePembayaran
  ValueNotifier<PaymentMethodsModel?> paymentChoosen = ValueNotifier(null);
  ///ValueNotifier for PilihWaktu
  TimeChoosenNotifier timeChoosen = TimeChoosenNotifier(
    TimeChoosen(
      startHour: null,
      duration: null,
    )
  );
  PilihWaktuController pilihWaktuController = PilihWaktuController([0,1,1,0,1,0,1,1,1,1,1,1,0,0,1,1]);
  CustomButtonController customButtonController = CustomButtonController(isLoading: false);

  // int dayFieldPrice = 69999;
  // int nightFieldPrice = 79999;
  // int nightHour = 17;
  


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      pilihWaktuController.isLoading = true;

      ///To create animation of moving scroll(Intended to inform the user that the field data is scrollable)
      fieldScrollController.animateTo(18, duration: const Duration(seconds: 2), curve: Curves.easeOutCubic);
      
      ///Set date of JadwalPenyewaan
      ///Only accept days from daysActive
      DateTime now = DateTime.now();
      if(widget.fieldModel.daysActive!.length < 7){
        List<String> hariHari = [
          'Senin',
          'Selasa',
          'Rabu',
          'Kamis',
          'Jumat',
          'Sabtu',
          'Minggu'
        ];
        String? hari;
        hari = hariHari[now.weekday - 1];
        while(!widget.fieldModel.daysActive!.contains(hari)){
          now = now.add(const Duration(days: 1));
          hari = hariHari[now.weekday - 1];
        }
      }
      dateChoosen.value = now;
      jadwalPenyewaanTextController.text = customDateFormat2(dateChoosen.value!);

      ///Get data from api AvailableField
      JSONModel json = await GateService.getAvailableField(fieldId: widget.fieldModel.id, date: dateChoosen.value!);

      if(json.statusCode == 200){
        setPilihWaktuInitialValue(
          json, 
          nearestBookHour: Variables.nearestBookHour, 
          // dateOfField: now.add(Duration(hours: widget.fieldModel.bookingOpenHour))
          dateOfField: DateTime(now.year, now.month, now.day).add(Duration(hours: widget.fieldModel.bookingOpenHour))
        );
      }
      else if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar(title: json.getErrorToString())
        );
      }

      pilihWaktuController.isLoading = false;
    });
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
              Navigator.pop(context);
            }, 
            icon: SvgPicture.asset('assets/icon/Caret-Left.svg')
          ),
          title: const Text(
            'Detail Lapangan',
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

        ///Body
        body: LayoutBuilder(
          builder: (p0context, p1constraint) {
            return NotificationListener<ScrollUpdateNotification>(
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
              child: SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: p1constraint.maxHeight
                  ),
              
                  ///Dividing content and button
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          
                          ///Image with field data
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
                  
                              ///Bunch of Text contain Field Data
                              Positioned.fill(
                                child: Container(
                                  // color: Colors.amber,
                                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                  ///For dividing notch(and System UI) and content(such as 'Lapangan #1', 'Rp 69.999,-/jam)
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).viewPadding.top + 71, //notch and systemUI + AppBar height
                                      ),
                                      Expanded(
                                        child: SizedBox(
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
                                                      Text(
                                                        widget.fieldModel.name,      //'Lapangan #1'
                                                        style: const TextStyle(
                                                          fontWeight: semiBold,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 28,),
                                                      Text(
                                                        '${customCurrencyFormat(widget.fieldModel.harga)},- /jam',          //'Rp 69.999,-/jam'
                                                        style: const TextStyle(
                                                          fontWeight: regular,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4,),
                                                      (widget.fieldModel.hargaMalam == null)
                                                          ? const SizedBox()
                                                          : Text(
                                                            '${customCurrencyFormat(widget.fieldModel.hargaMalam!)},- /jam diatas pukul ${customTimeFormat(widget.fieldModel.waktuMulaiMalamHour!, widget.fieldModel.waktuMulaiMalamMinute!)}',        //'Rp 79.999,- /jam diatas pukul 17.00'
                                                            style: const TextStyle(
                                                              fontWeight: regular,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                      const SizedBox(height: 28,),
                                                      Text(
                                                        customActiveDaysString(widget.fieldModel.daysActive!),      //'Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu'
                                                        style: const TextStyle(
                                                          fontWeight: semiBold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4,),
                                                      Text(
                                                        '${customTimeFormat(widget.fieldModel.bookingOpenHour, widget.fieldModel.bookingOpenMinute)} hingga ${customTimeFormat(widget.fieldModel.bookingCloseHour, widget.fieldModel.bookingCloseMinute)}',         //'07:00 hingga 22:00'
                                                        style: const TextStyle(
                                                          fontWeight: semiBold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                                                            
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ),
                            ],
                          ),  ///End of Image and Field Data
                  
                          
                  
                          ///JadwalPenyewaan, PilihWaktu, MetodePembayaran
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 32, 
                              bottom: 16, 
                              right: 16, 
                              left: 16
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          
                                ///JadwalPenyewaan (Text and TextField)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jadwal Penyewaan',
                                      style: TextStyle(
                                        fontWeight: semiBold,
                                        fontSize: 16,
                                      ),
                                    ),
            
                                    const SizedBox(height: 4,),
            
                                    Stack(
                                      children: [
                                        SizedBox(
                                          width: 220,
                                          child: ValueListenableBuilder(
                                            valueListenable: dateChoosen,
                                            builder: (context, value, child) {
            
                                              if(dateChoosen.value != null){
                                                jadwalPenyewaanTextController.text = customDateFormat2(dateChoosen.value!);
                                              }
            
                                              return CustomTextfield(
                                                controller: jadwalPenyewaanTextController,
                                                type: CustomTextfieldType.edit,
                                                enabledBorderColor: primaryLightestColor,
                                              );
                                            }
                                          ),
                                        ),
            
                                        Positioned.fill(
                                          child: GestureDetector(
                                            onLongPress: () {},
                                            onTap: () async{
                                              DateTime? tempDate = await showDatePicker(
                                                context: context, 
                                                initialDate: dateChoosen.value!, 
                                                firstDate: DateTime.now(), 
                                                lastDate: DateTime.now().add(const Duration(days: 7)),

                                                ///Melarang pemilihan hari diluar hari yang ditentukan lapangan
                                                selectableDayPredicate: (day) {
                                                  List<String> hariHari = [
                                                    'Senin',
                                                    'Selasa',
                                                    'Rabu',
                                                    'Kamis',
                                                    'Jumat',
                                                    'Sabtu',
                                                    'Minggu'
                                                  ];
                                                  String? hari;
                                                  hari = hariHari[day.weekday - 1];
                                                  if(widget.fieldModel.daysActive!.contains(hari)){
                                                    return true;
                                                  }
                                                  return false;
                                                },
                                                
                                                fieldLabelText: 'Tanggal (cth: 05/31/2023)',
                                                helpText: 'Pilih Tanggal',
                                                initialEntryMode: DatePickerEntryMode.calendarOnly,
                                                builder: (context, child) {
                                                  return Theme(
                                                    data: ThemeData.light().copyWith(
                                                      colorScheme: const ColorScheme.light(
                                                        primary: primaryBaseColor,
                                                        onPrimary: Colors.white
                                                      )
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              );
                                              if(tempDate != null){
                                                pilihWaktuController.isLoading = true;
                                                pilihWaktuController.revertBackList();
                                                dateChoosen.value = tempDate;
                                                timeChoosen.setTimeData(null, null, widget.fieldModel.waktuMulaiMalamHour);
                                                JSONModel json = await GateService.getAvailableField(
                                                  fieldId: widget.fieldModel.id, date: dateChoosen.value!
                                                );
                                                if(json.statusCode == 200){
                                                  setPilihWaktuInitialValue(
                                                    json, 
                                                    nearestBookHour: Variables.nearestBookHour, 
                                                    dateOfField: tempDate.add(Duration(hours: widget.fieldModel.bookingOpenHour))
                                                  );
                                                }
                                                else if(context.mounted){
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    CustomSnackbar(title: json.getErrorToString(),)
                                                  );
                                                }
                                                pilihWaktuController.isLoading = false;

                                              }
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
            
                                const SizedBox(height: 16,),
                          
                                ///PilihWaktu
                                ValueListenableBuilder(
                                  valueListenable: dateChoosen,
                                  builder: (context, value, child) {
                                    return PilihWaktu(
                                      controller: pilihWaktuController,
                                      startHour: widget.fieldModel.bookingOpenHour,
                                      ///Limiting the input duration
                                      hourLimit: 2,
                                      callback: ({duration1, startHour1}) {
                                        timeChoosen.setTimeData(startHour1, duration1, widget.fieldModel.waktuMulaiMalamHour);
                                      },
                                    );
                                  }
                                ),
            
                                const SizedBox(height: 16,),
            
                                ///MetodePembayaran
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Metode Pembayaran',
                                      style: TextStyle(
                                        fontWeight: semiBold,
                                        fontSize: 16,
                                      ),
                                    ),
            
                                    const SizedBox(height: 4,),
            
                                    ///MethodButton
                                    GestureDetector(
                                      onTap: () async{
                                        PaymentMethodsModel? tempPaymentMethod = await showMetodePembayaran(context, p1constraint.maxHeight);
                                        if(tempPaymentMethod != null){
                                          paymentChoosen.value = tempPaymentMethod;
                                          timeChoosen.setPaymentMethodIsChoosen(true);
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: primaryLightColor,
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: primaryLightestColor)
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ValueListenableBuilder(
                                                valueListenable: paymentChoosen,
                                                builder: (context, value, child) {
                                                  
                                                  if(paymentChoosen.value != null){
                                                    return Row(
                                                      children: [
                                                        ///ImageLogo
                                                        Container(
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                            // color: Colors.red,
                                                            image: DecorationImage(
                                                              image: NetworkImage(paymentChoosen.value!.logo),
                                                            )
                                                          ),
                                                        ),
            
                                                        ///Name
                                                        Expanded(
                                                          child: SizedBox(
                                                            // color: Colors.green,
                                                            child: Text(paymentChoosen.value!.paymentMethodName),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                  else{
                                                    return const Text(
                                                      'Metode Pembayaran belum dipilih',
                                                      style: TextStyle(
                                                        fontWeight: regular,
                                                        fontSize: 12
                                                      ),
                                                    );
                                                  }
                                                }
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              'assets/icon/Caret-Down.svg',
                                              height: 24,
                                              width: 24,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
            
                                const SizedBox(height: 16,),
            
                                ///BiayaSewa
                                ValueListenableBuilder(
                                  valueListenable: timeChoosen,
                                  builder: (context, value, child) {
                                    return (timeChoosen.startHour != null && timeChoosen.duration != null && timeChoosen.paymentMethodIsChoosen == true) 
                                        ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Biaya Sewa',
                                              style: TextStyle(
                                                fontWeight: semiBold,
                                                fontSize: 16
                                              ),
                                            ),
                                            
                                            const SizedBox(height: 4,),
            
                                            BiayaSewa(
                                              fieldDayPrice: widget.fieldModel.harga,
                                              fieldNightPrice: widget.fieldModel.hargaMalam,
                                              durationDay: timeChoosen.dayDuration,
                                              durationNight: timeChoosen.nightDuration, 
                                              adminPriceNominal: paymentChoosen.value!.paymentAdminNominal!,
                                              debugColor: false,
                                            )
                                          ],
                                        ) : const SizedBox();
                                    }
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                  
                      ///Button Konfirmasi Jadwal
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        child: ValueListenableBuilder(
                          valueListenable: timeChoosen,
                          builder: (context, value, child) {
                            return CustomButton(
                              value: 'Konfirmasi Jadwal', 
                              size: const Size(double.infinity, 48),
                              controller: customButtonController,
                              onPressed: (timeChoosen.startHour != null && timeChoosen.duration != null && timeChoosen.paymentMethodIsChoosen == true )
                                  ? () async{
                                    customButtonController.isLoading = true;
                                    // await Future.delayed(Duration(seconds: 1));
                                    int bookingTime = pilihWaktuController.value.indexOf(2) + widget.fieldModel.bookingOpenHour;
                                    int duration = 0;
                                    for(int i in pilihWaktuController.value){
                                      if(i == 2){
                                        duration += 1;
                                      }
                                    }

                                    JSONModel json = await GateService.postBookingMobile(
                                      fieldId: widget.fieldModel.id, 
                                      bookingDate: dateChoosen.value!, 
                                      bookingTime: bookingTime, 
                                      duration: duration, 
                                      paymentMethodId: paymentChoosen.value!.paymentMethodsId
                                    );

                                    if(json.statusCode == 200 && context.mounted){
                                      // Navigator.pushAndRemoveUntil(
                                      //   context, 
                                      //   MaterialPageRoute(builder: (context) => DetailPenyewaanScreen(bookingId: json.data['booking_id'],)), 
                                      //   (route) => route.isFirst,
                                      // );
                                      Navigator.pushAndRemoveUntil(
                                        context, 
                                        MaterialPageRoute(builder: (context) => const MainScreen(indexChoosen: 0,)), 
                                        (route) => false,
                                      );
                                      Navigator.push(
                                        context, 
                                        MaterialPageRoute(builder: (context) => DetailPenyewaanScreen(
                                          bookingId: json.data['booking_id'],
                                        ),)
                                      );
                                    }
                                    else if(context.mounted){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        CustomSnackbar(title: json.getErrorToString())
                                      );
                                    }
                                    customButtonController.isLoading = false;
                                  } 
                                  : null,
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        )
      ),
    );
  }

  ///Set initialValue of pilihWaktuController from JSONModel
  void setPilihWaktuInitialValue(JSONModel json, {required int nearestBookHour, required DateTime dateOfField}){

    ///Convert Map<String, dynamic> json.data to List<int> listAvailableField
    List<int> listAvailableField = [];
    (json.data as Map<String, dynamic>).forEach((key, value) => listAvailableField.add((value as bool) ? 1 : 0));

    DateTime now = DateTime.now();

    ///if dateOfField > now
    if(dateOfField.compareTo(now) == 1){
      Duration difference = dateOfField.difference(now);
      int differenceHours = difference.inHours;
      if(nearestBookHour >= differenceHours){
        int remainderHour = nearestBookHour - differenceHours + 1;
        for(int i = 0; i < remainderHour; i++){
          listAvailableField[i] = 0;
        }
      }
    }
    ///if dateOfField < now
    else{
      Duration difference = now.difference(dateOfField);
      int differenceHours = difference.inHours;
      for(int i = 0; i < differenceHours + nearestBookHour + 1 && i < listAvailableField.length; i++){
        listAvailableField[i] = 0;
      }
    }

    ///Set initialValue of pilihWaktuController
    pilihWaktuController.initialValue = listAvailableField;
  }
}