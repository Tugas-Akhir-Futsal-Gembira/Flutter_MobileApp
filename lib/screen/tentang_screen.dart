import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TentangScreen extends StatelessWidget {
  const TentangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/football doodle.jpg'),
          colorFilter: ColorFilter.mode(Color(0xFA2F2F2F), BlendMode.srcATop),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        ///AppBar
        appBar: AppBar(
          toolbarHeight: 71,
          backgroundColor: primaryBaseColor,
          elevation: 0,
          titleSpacing: 20,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icon/Caret-Left.svg'),
          ),
          title: const Text(
            'Tentang Futsal Gembira',
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 20,
            ),
          ),
        ),

        ///Body
        body: SingleChildScrollView(
          child: Column(
            children: [

              ///The image
              AspectRatio(
                aspectRatio: 428/266,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/tentang/futsal gembira photo3.jpg'), 
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),

              ///The texts with padding
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text('Futsal Gembira', style: TextStyle(fontWeight: semiBold, fontSize: 24),),
                    const SizedBox(height: 16,),

                    ///The first row: Location
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icon/mdi_address-marker.svg', width: 32, height: 32,),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(minHeight: 32),
                            child: GestureDetector(
                              onTap: () async{

                                ///Link of Google Maps - Futsal Gembira
                                final Uri url = Uri(
                                  scheme: 'https',
                                  host: 'goo.gl',
                                  path: '/maps/zbqUWaZcKpTt74Hh7'
                                );

                                if(!await launchUrl(url, mode: LaunchMode.externalApplication)){
                                  if(context.mounted){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackbar(title: 'Tidak dapat membuka link di browser eksternal')
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                'Jalan Alumunium Raya no. 2, Tj. Mulia Hilir, Kec. Medan Deli, Kota Medan, Sumatera Utara 20241',
                                style: TextStyle(fontWeight: regular, fontSize: 16, decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 16,),

                    ///The second row: Phone
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/icon/Phone.svg', width: 32, height: 32,),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(minHeight: 32),
                            child: GestureDetector(
                              onTap: () async{

                                ///Telephone to Futsal Gembira
                                final Uri url = Uri.parse('tel:082363601765');

                                if(!await launchUrl(url, mode: LaunchMode.externalApplication)){
                                  if(context.mounted){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      CustomSnackbar(title: 'Tidak dapat membuka panggilan di aplikasi eksternal')
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                '082363601765',
                                style: TextStyle(fontWeight: regular, fontSize: 16, decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}