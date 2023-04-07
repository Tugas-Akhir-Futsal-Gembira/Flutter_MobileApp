import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

AppBar pengaturanAppBar = AppBar(
  elevation: 0,
  backgroundColor: primaryBaseColor,
  toolbarHeight: 71,
  titleSpacing: 20,
  title: Text(
    'Pengaturan',
    style: TextStyle(
      fontSize: 20,
      fontWeight: semiBold
    ),
  ),
);