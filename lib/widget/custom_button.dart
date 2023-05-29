import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, 
    required this.value, 
    this.onPressed, 
    required this.size, 
    this.fontSize = 16,
    this.isLoading = false,
  });

  final String value;
  final void Function()? onPressed;
  final double fontSize;
  final Size size;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isLoading) ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        disabledBackgroundColor: primaryLightestColor,
        fixedSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
      child: (isLoading) 
          ? const AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(
                backgroundColor: infoColor,
                color: Colors.white
              ),
            ),
          ) 
          : Text(
            value, 
            style: TextStyle(
              color: Colors.black, 
              fontWeight: semiBold, 
              fontSize: fontSize,
            ),
          ),
    );
  }
}