import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar riwayatPenyewaanAppBar = AppBar(
  elevation: 0,
  backgroundColor: primaryBaseColor,
  toolbarHeight: 71,
  titleSpacing: 20,
  title: Text(
    'Riwayat Penyewaan',
    style: TextStyle(
      fontSize: 20,
      fontWeight: semiBold
    ),
  ),
  actions: [
    Tooltip(
      message: 'Daftar Riwayat Penyewaan diurutkan berdasarkan tanggal dibuatnya penyewaan lapangan',
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: regular,
        fontSize: 12
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10), 
          bottomLeft: Radius.circular(10), 
          bottomRight: Radius.circular(10)
        ),
        color: Colors.white,
        border: Border.all(
          color: primaryLightestColor
        )
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      showDuration: const Duration(seconds: 2),
      triggerMode: TooltipTriggerMode.tap,
      child: SvgPicture.asset('assets/icon/Info-Circle.svg'),
    ),
    const SizedBox(width: 16,),
  ],
);