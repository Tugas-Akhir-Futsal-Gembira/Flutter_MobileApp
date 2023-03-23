import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/field_gridview.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/welcome_container.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';

class BerandaScreen extends StatelessWidget {
  const BerandaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 1,
          color: primaryLightestColor,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  WelcomeContainer(name: 'Chandra',),
                  SizedBox(height: 16,),
                  FieldGridView(name: 'Chandra'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}