import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.value, this.onPressed, required this.size});

  final String value;
  final void Function()? onPressed;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        fixedSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
      child: Text(
        value, 
        style: TextStyle(
          color: Colors.black, 
          fontWeight: semiBold, 
          fontSize: 20
        ),
      ),
    );
  }
}