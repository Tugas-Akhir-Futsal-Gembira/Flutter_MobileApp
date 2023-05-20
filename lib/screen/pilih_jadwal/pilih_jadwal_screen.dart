import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/pilih_waktu.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/show_metode_pembayaran.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
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
  ValueNotifier<DateTime?> dateChoosen = ValueNotifier(null);

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
                                padding: const EdgeInsets.all(16),
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
                              const PilihWaktu(),

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

                                  GestureDetector(
                                    onTap: () {
                                      showMetodePembayaran(context, p1constraint.maxHeight);
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
                                          const Text(
                                            'Metode Pembayaran belum dipilih',
                                            style: TextStyle(
                                              fontWeight: regular,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Spacer(),
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
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                
                    ///Button
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