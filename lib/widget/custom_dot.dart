import 'package:flutter/material.dart';

class CustomDot extends StatelessWidget {
  const CustomDot({
    super.key,
    required this.size,
    this.color = Colors.white,
    });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color
      ),
    );
  }
}