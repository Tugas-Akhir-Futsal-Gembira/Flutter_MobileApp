import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class CustomChipController extends ValueNotifier{
  CustomChipController({bool? isActive = false}) : super(null){
    (isActive != null) ? _isActive = isActive : false;
  }

  late bool _isActive;

  set isActive(bool value){
    _isActive = value;
    notifyListeners();
  }

  bool get isActive{
    return _isActive;
  }

}

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, this.value, this.controller, this.onTap});

  final String? value;
  final CustomChipController? controller;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        ///Button Chip and its own content such as Text and Container
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 1.4,
              sigmaY: 1.4,
            ),
            child: Container(
              height: 28,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: primaryLightestColor.withOpacity(0.15)
              ),
              child: ValueListenableBuilder(
                valueListenable: (controller != null) ? controller! : CustomChipController(),
                builder: (context, _, child) {
                  return Text(
                    value.toString(),
                    style: TextStyle(
                      fontWeight: medium, 
                      fontSize: 14,
                      color: (controller != null && controller!.isActive) ? infoColor : Colors.white
                    ),
                  );
                }
              ),
            ),
          ),
        ),

        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              highlightColor: primaryBaseColor.withOpacity(0.5),
              splashColor: primaryLightestColor.withOpacity(0.5)
            ),
          ),
        )
      ],
    );
  }
}