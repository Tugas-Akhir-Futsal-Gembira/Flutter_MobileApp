

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/profile/profile_model.dart';
import 'package:flutter_application_futsal_gembira/screen/landing_page_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/main_screen.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';
import 'package:flutter_application_futsal_gembira/variables/variables.dart';

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
        ///Find accessToken in SharedPreferences
        String? accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

        ///Get profile data from API
        if(accessToken != null){
          JSONModel json = await GateService.getMe();
          if(json.statusCode == 200 && json.data != null){
            Variables.profileData = ProfileModel.fromJSON(json.data!);
          }
        }

        ///Navigate to MainScreen if accessToken was saved from last usage and profileData is not null when taken from API
        ///Else it will navigate to LandingPageScreen
        if(context.mounted){
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (context) => (accessToken != null && Variables.profileData != null) 
                  ? const MainScreen()
                  : const LandingPageScreen(),
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