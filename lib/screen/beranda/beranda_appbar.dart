import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar berandaAppBar = AppBar(
  elevation: 0,
  backgroundColor: primaryBaseColor,
  toolbarHeight: 71,
  titleSpacing: 20,
  title: const Text(
    'Futsal Gembira',
    style: TextStyle(
      fontSize: 20,
      fontWeight: semiBold
    ),
  ),
  flexibleSpace: SafeArea(
    child: Align(
      alignment: Alignment.topRight,
      child: SvgPicture.asset('assets/icon/beranda/Group 247.svg', height: 71,)
    )
  ),
);