import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class CustomButtonController extends ValueNotifier{
  CustomButtonController({bool isLoading = false}) : super(isLoading){
    _isLoading = isLoading;
  }
  
  late bool _isLoading;

  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
}

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key, 
    required this.value, 
    this.onPressed, 
    required this.size, 
    this.fontSize = 16,
    this.controller,
  });

  final String value;
  final void Function()? onPressed;
  final double fontSize;
  final Size size;
  // final bool isLoading;
  final CustomButtonController? controller;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  late final CustomButtonController tempController;

  @override
  void initState() {
    tempController = (widget.controller != null) 
        ? widget.controller!
        : CustomButtonController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: tempController,
      builder: (context, value, child) {
        return ElevatedButton(
          onPressed: (tempController._isLoading) ? null : widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            disabledBackgroundColor: primaryLightestColor,
            fixedSize: widget.size,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          ///If isLoading show circularProgressIndicator
          child: (tempController._isLoading) 
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
                widget.value, 
                style: TextStyle(
                  color: Colors.black, 
                  fontWeight: semiBold, 
                  fontSize: widget.fontSize,
                ),
              ),
        );
      }
    );
  }
}