

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/landing_page_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

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
    timer = Timer(const Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandindPageScreen(),));
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBaseColor,
      body: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(64.0),
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