

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/landing_page_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/main_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(milliseconds: 1500), 
      () async{
        String? accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

        if(context.mounted){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (context) => (accessToken == null) ? const LandingPageScreen() : const MainScreen(),
            )
          );
        }
      }
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage('assets/image/landing_page/Lapangan futsal wallpaper 3.jpg'), 
      context
    );
    precacheImage(
      const AssetImage('assets/image/football doodle.jpg'), 
      context
    );
    precacheImage(
      const AssetImage('assets/image/Lapangan futsal wallpaper.jpg'), 
      context
    );
    precacheImage(
      const AssetImage('assets/image/cara_bayar/debit credit card wallpaper.jpg'), 
      context
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: primaryBaseColor,
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.all(64.0),
            child: Text(
              'Futsal\nGembira', 
              style: TextStyle(
                color: Colors.white, 
                fontWeight: semiBold,
                fontSize: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}