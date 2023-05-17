import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/login_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandindPageScreen extends StatelessWidget {
  const LandindPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBaseColor,
      body: Column(
        children: [

          ///The Image
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/image/landing_page/Lapangan futsal wallpaper 3.jpg'
                  ),
                  fit: BoxFit.cover
                ),
              ),
              child: Container(
                width: 135,
                height: 61,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: const Text(
                  'Futsal\nGembira', 
                  style: TextStyle(
                    fontWeight: semiBold, 
                    fontSize: 20,
                    color: primaryBaseColor
                  ),
                ),
              ),
            )
          ),

          ///The container below image
          Stack(
            children: [

              Positioned(
                right: 0,
                child: SvgPicture.asset(
                  'assets/icon/landing_page/Trophy.svg',
                ),
              ),

              Positioned(
                bottom: 0,
                child: SvgPicture.asset(
                  'assets/icon/landing_page/Star.svg',
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Jadilah pemenang', style: TextStyle(fontSize: 32, fontWeight: semiBold, height: 1.0),),
                    const SizedBox(height: 10,),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 250
                      ),
                      child: const Text(
                        'Tidak hanya di atas lapangan tapi juga di hati orang-orang terdekat kita',
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: light
                        ),
                      ),
                    ),
                    const SizedBox(height: 50,),

                    ///'Mulai' Button
                    Center(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                              // builder: (context) => const ExampleScren(),
                            )
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(202, 44),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                        ),
                        child: const Text(
                          'Mulai', 
                          style: TextStyle(
                            color: Colors.black, 
                            fontWeight: semiBold, 
                            fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}