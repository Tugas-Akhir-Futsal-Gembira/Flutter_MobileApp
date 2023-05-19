import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      alignment: Alignment.center,
      height: 103,
      decoration: BoxDecoration(
        color: primaryLightColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(
        'Anda tidak punya pemesanan aktif',
        style: TextStyle(
          fontWeight: semiBold,
          fontSize: 16,
          color: primaryLightestColor
        ),
      )
    );
  }
}