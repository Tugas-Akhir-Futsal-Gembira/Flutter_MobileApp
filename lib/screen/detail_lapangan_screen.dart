import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/pilih_jadwal_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailLapanganScreen extends StatefulWidget {
  const DetailLapanganScreen({super.key});

  @override
  State<DetailLapanganScreen> createState() => _DetailLapanganScreenState();
}

class _DetailLapanganScreenState extends State<DetailLapanganScreen> {

  ScrollController scrollController = ScrollController();
  ValueNotifier<double> opacity = ValueNotifier(0);

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
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/image/Lapangan futsal wallpaper.jpg'),
                                    fit: BoxFit.fill
                                  )
                                ),
                              ),
                              itemCount: 5,
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
                              
                                  for(int i = 0; i < 5; i++)
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
                                const Text(
                                  'Lapangan #1',
                                  style: TextStyle(
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
                                              children: const [
                                                Text(
                                                  'Harga Sewa',
                                                  style: TextStyle(
                                                    fontWeight: regular,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                      
                                                Text(
                                                  'Rp 69.999,-',
                                                  style: TextStyle(
                                                    fontWeight: semiBold,
                                                    fontSize: 16
                                                  ),
                                                )
                                              ],
                                            ),
                                      
                                            ///Night Rent Price
                                            Column(
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
                                                  children: const [
                                                    Text(
                                                      'Rp 79.999,-',
                                                      style: TextStyle(
                                                        fontWeight: semiBold,
                                                        fontSize: 16
                                                      ),
                                                    ),
                                      
                                                    SizedBox(width: 16,),
                                      
                                                    Text(
                                                      'mulai pukul 17:00',
                                                      style: TextStyle(
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
                                        children: const [
                                          Text(
                                            'Menerima pesanan sewa setiap hari',
                                            style: TextStyle(
                                              fontWeight: regular,
                                              fontSize: 12,
                                            ),
                                          ),
                                
                                          Text(
                                            'Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu',
                                            style: TextStyle(
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
                                        children: const [
                                          Text(
                                            'Menerima pesanan sewa setiap pukul',
                                            style: TextStyle(
                                              fontWeight: regular,
                                              fontSize: 12,
                                            ),
                                          ),
                                
                                          Text(
                                            '10:00 hingga 21:00',
                                            style: TextStyle(
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
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryLightColor,
                                    border: Border.all(color: primaryLightestColor)
                                  ),
                                  child: const Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Facilisis gravida neque convallis a cras. Sapien eget mi proin sed libero enim sed faucibus turpis.',
                                    style: TextStyle(
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
                            Row(
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
                                onPressed: (){
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => const PilihJadwalScreen()
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
        ),
      ),
    );
  }
}