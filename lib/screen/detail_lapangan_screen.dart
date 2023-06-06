import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/field/field_model.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/menunggu_pembayaran_model.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/pilih_jadwal_screen.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailLapanganScreen extends StatefulWidget {
  const DetailLapanganScreen({super.key, required this.id});

  final int id;

  @override
  State<DetailLapanganScreen> createState() => _DetailLapanganScreenState();
}

class _DetailLapanganScreenState extends State<DetailLapanganScreen> {

  ValueNotifier isLoadingValueNotifier = ValueNotifier(false);
  ScrollController scrollController = ScrollController();
  ValueNotifier<double> opacity = ValueNotifier(0);
  bool unfinishedTransaction = false;
  FieldModel? fieldModel;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {

    ValueNotifier<int> pageViewIndex = ValueNotifier(0);

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
        body: ValueListenableBuilder(
          valueListenable: isLoadingValueNotifier,
          builder: (context, value, child) {
            if(isLoadingValueNotifier.value == true){
              return const SafeArea(
                child: LinearProgressIndicator(
                  backgroundColor: Colors.white,
                  color: infoColor,
                ),
              );
            }
            else{
              if (fieldModel == null){
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  Navigator.pop(context);
                });
                return const SizedBox();
              }
              else{
                return child!;
              }
            }
          },
          child: LayoutBuilder(
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
              
                    ///Dividing Content and Button
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                                
                            ///PageView - Images
                            AspectRatio(
                              aspectRatio: 428/302,
                              child: PageView.builder(
                                onPageChanged: (value) {
                                  pageViewIndex.value = value;
                                },
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      // image: AssetImage('assets/image/Lapangan futsal wallpaper.jpg'),
                                      image: NetworkImage(fieldModel!.gallery[index]),
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                ),
                                itemCount: fieldModel!.gallery.length,
                              )
                            ),
                                
                            ///PageView indicator
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                // color: Colors.amber,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                
                                    for(int i = 0; i < fieldModel!.gallery.length; i++)
                                      ValueListenableBuilder(
                                        valueListenable: pageViewIndex,
                                        builder: (context, value, child) {
                                          return Container(
                                            height: 10,
                                            width: 10,
                                            margin: EdgeInsets.only(right: (i < 4) ? 6 : 0),
                                            decoration: BoxDecoration(
                                              color: (pageViewIndex.value == i) ? infoColor : primaryLightestColor,
                                              shape: BoxShape.circle
                                            ),
                                          );
                                        }
                                      )
                                  ],
                                ),
                              ),
                            ),
                                
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32, top: 16, right: 16, left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                
                                  ///Text Field Name
                                  Text(
                                    fieldModel!.name,         //'Lapangan #1'
                                    style: const TextStyle(
                                      fontWeight: semiBold,
                                      fontSize: 24,
                                    ),
                                  ),
                                
                                  const SizedBox(height: 16,),
                                
                                  ///Rents, Days, Hours
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: primaryLightColor,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: primaryLightestColor)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Wrap(
                                            alignment: WrapAlignment.spaceBetween,
                                            runSpacing: 16,
                                        
                                            ///Rent Price and Night Rent Price
                                            children: [
                                        
                                              ///Rent Price
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Harga Sewa',
                                                    style: TextStyle(
                                                      fontWeight: regular,
                                                      fontSize: 12,
                                                    ),
                                                  ),

                                                  Text(
                                                    '${customCurrencyFormat(fieldModel!.harga)},-',      //'Rp 69,999,-'
                                                    style: const TextStyle(
                                                      fontWeight: semiBold,
                                                      fontSize: 16
                                                    ),
                                                  )
                                                ],
                                              ),
                                        
                                              ///Night Rent Price
                                              (fieldModel!.hargaMalam == null)
                                                  ? const SizedBox()
                                                  : Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        'Harga Sewa Khusus Malam',
                                                        style: TextStyle(
                                                          fontWeight: regular,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                            
                                                      Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        children: [
                                                          Text(
                                                            '${customCurrencyFormat(fieldModel!.hargaMalam!)},-',      //'Rp 79,999,-',
                                                            style: const TextStyle(
                                                              fontWeight: semiBold,
                                                              fontSize: 16
                                                            ),
                                                          ),
                                            
                                                          const SizedBox(width: 16,),
                                            
                                                          Text(
                                                            'mulai pukul ${customTimeFormat(fieldModel!.waktuMulaiMalamHour!, fieldModel!.waktuMulaiMalamMinute!)}',      //'mulai pukul 17:00
                                                            style: const TextStyle(
                                                              fontWeight: light,
                                                              fontSize: 12,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                        
                                            ],
                                          ),
                                        ),
                                
                                        const SizedBox(height: 20,),
                                
                                        ///Days
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Menerima pesanan sewa setiap hari',
                                              style: TextStyle(
                                                fontWeight: regular,
                                                fontSize: 12,
                                              ),
                                            ),
                                  
                                            Text(
                                              customActiveDaysString(fieldModel!.daysActive!),       //'Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu'
                                              style: const TextStyle(
                                                fontWeight: semiBold,
                                                fontSize: 16
                                              ),
                                            )
                                          ],
                                        ),
                                
                                        const SizedBox(height: 20,),
                                
                                        ///Hour
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Menerima pesanan sewa setiap pukul',
                                              style: TextStyle(
                                                fontWeight: regular,
                                                fontSize: 12,
                                              ),
                                            ),
                                  
                                            Text(
                                              '${customTimeFormat(fieldModel!.bookingOpenHour, fieldModel!.bookingOpenMinute)} hingga ${customTimeFormat(fieldModel!.bookingCloseHour, fieldModel!.bookingCloseMinute)}',       //'10:00 hingga 21:00'
                                              style: const TextStyle(
                                                fontWeight: semiBold,
                                                fontSize: 16
                                              ),
                                            )
                                          ],
                                        ),
                                
                                      ],
                                    ),
                                  ),
                                
                                  const SizedBox(height: 32,),
                                
                                  const Text(
                                    'Deskripsi Lapangan',
                                    style: TextStyle(
                                      fontWeight: semiBold,
                                      fontSize: 20,
                                    ),
                                  ),
                                
                                  const SizedBox(height: 16,),
                                
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: primaryLightColor,
                                      border: Border.all(color: primaryLightestColor)
                                    ),
                                    child: Text(
                                      fieldModel!.description!,       //'Lorem ipsum dolor sit amet, consectetur...'
                                      style: const TextStyle(
                                        fontWeight: regular,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
              
              
                        ///Button
                        Container(
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                          width: double.infinity,
                          child: Column(
                            children: [

                              (unfinishedTransaction == false)
                                  ? const SizedBox()
                                  : Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icon/Alert-Triangle.svg', 
                                        colorFilter: const ColorFilter.mode(
                                          warningColor, 
                                          BlendMode.srcATop
                                        ),
                                        // color: warningColor,
                                      ),
                                      const SizedBox(width: 4,),
                                      const Expanded(
                                        child: Text(
                                          'Lakukan pembayaran pada penyewaan yang belum selesai',
                                          style: TextStyle(
                                            fontWeight: semiBold,
                                            fontSize: 12,
                                            color: warningColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                              const SizedBox(height: 4,),
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  value: 'Pilih Jadwal', 
                                  size: const Size(double.infinity, 48),
                                  onPressed: (unfinishedTransaction == true)
                                      ? null
                                      :
                                      (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(
                                            builder: (context) => PilihJadwalScreen(fieldModel: fieldModel!,)
                                          )
                                        );
                                      },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }, 
          )
        ),
      ),
    );
  }

  Future<void> refresh() async{
    isLoadingValueNotifier.value = true;
    

    /// [
    ///     jsonDetailField
    ///     jsonActiveBooking
    /// ]
    List<JSONModel> listJson = await Future.wait([
      GateService.getDetailField(id: widget.id),
      GateService.getActiveBookingUser()
    ]);

    JSONModel jsonDetailField = listJson[0];
    JSONModel jsonActiveBooking = listJson[1];

    ///if getDetailField and getActiveBookingUser status = 200
    ///fill in fieldModel and fill in unfinishedTransaction by looking any 'waiting' transaction from getActiveBookingUser
    if(jsonDetailField.statusCode == 200 && jsonActiveBooking.statusCode == 200){
      fieldModel = FieldModel.fromJSONDetailField(jsonDetailField.data, widget.id);
      AbstractPenyewaanModel? penyewaanModel = (jsonActiveBooking.data != null)
          ? AbstractPenyewaanModel.fromJSON(jsonActiveBooking.data)
          : null;

      unfinishedTransaction = (penyewaanModel.runtimeType == MenungguPembayaranModel);
    }
    else if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(title: jsonDetailField.getErrorToString(), color: error2Color,),
      );
    }

    isLoadingValueNotifier.value = false;
  }
}