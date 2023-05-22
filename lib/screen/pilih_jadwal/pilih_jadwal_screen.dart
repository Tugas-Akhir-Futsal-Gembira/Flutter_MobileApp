import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/payment_method/payment_methods.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/time_choosen_notifier.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/pilih_waktu.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/show_metode_pembayaran.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/widget/biaya_sewa.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PilihJadwalScreen extends StatefulWidget {
  const PilihJadwalScreen({super.key});

  @override
  State<PilihJadwalScreen> createState() => _PilihJadwalScreenState();
}

class _PilihJadwalScreenState extends State<PilihJadwalScreen> {

  ScrollController fieldScrollController = ScrollController();
  TextEditingController jadwalPenyewaanTextController = TextEditingController();
  ///ValueNotifier for JadwalPenyewaan
  ValueNotifier<DateTime?> dateChoosen = ValueNotifier(null);
  ///ValueNotifier for MetodePembayaran
  ValueNotifier<PaymentMethods?> paymentChoosen = ValueNotifier(null);
  ///ValueNotifier for PilihWaktu
  TimeChoosenNotifier timeChoosen = TimeChoosenNotifier(
    TimeChoosen(
      startHour: null,
      duration: null,
    )
  );
  // PilihWaktuController pilihWaktuController = PilihWaktuController();

  int dayFieldPrice = 69999;
  int nightFieldPrice = 79999;
  int nightHour = 17;
  


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      ///To create animation of moving scroll(Intended to inform the user that the field data is scrollable)
      fieldScrollController.animateTo(18, duration: const Duration(seconds: 2), curve: Curves.easeOutCubic);
      
      dateChoosen.value = DateTime.now();
      jadwalPenyewaanTextController.text = customDateFormat2(dateChoosen.value!);
    });
  }

  @override
  Widget build(BuildContext context) {

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
            return SingleChildScrollView(
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
                                        child: SingleChildScrollView(
                                          controller: fieldScrollController,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              SizedBox(height: 18,),
                                              Text(
                                                'Lapangan #1',
                                                style: TextStyle(
                                                  fontWeight: semiBold,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              SizedBox(height: 28,),
                                              Text(
                                                'Rp 69.999,- /jam',
                                                style: TextStyle(
                                                  fontWeight: regular,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                'Rp 79.999,- /jam diatas pukul 17.00',
                                                style: TextStyle(
                                                  fontWeight: regular,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(height: 28,),
                                              Text(
                                                'Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu',
                                                style: TextStyle(
                                                  fontWeight: semiBold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(height: 4,),
                                              Text(
                                                '07:00 hingga 22:00',
                                                style: TextStyle(
                                                  fontWeight: semiBold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                        
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ],
                        ),
                
                        
                
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
                                              lastDate: dateChoosen.value!.add(const Duration(days: 7)),
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
                                              dateChoosen.value = tempDate;
                                              timeChoosen.setTimeData(null, null, nightHour);
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
                                    // controller: pilihWaktuController,
                                    callback: ({duration1, startHour1}) {
                                      timeChoosen.setTimeData(startHour1, duration1, nightHour);
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
                                      PaymentMethods? tempPaymentMethod = await showMetodePembayaran(context, p1constraint.maxHeight);
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
                                                            image: AssetImage(paymentChoosen.value!.logo),
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
                                            fieldDayPrice: dayFieldPrice,
                                            fieldNightPrice: nightFieldPrice,
                                            durationDay: timeChoosen.dayDuration,
                                            durationNight: timeChoosen.nightDuration, 
                                            adminPriceNominal: paymentChoosen.value!.ppnNominal!,
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
                      child: CustomButton(
                        value: 'Konfirmasi Jadwal', 
                        size: const Size(double.infinity, 48),
                        onPressed: (){},
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        )
      ),
    );
  }
}