

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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