import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CustomTextfieldType{
  normal,
  password,
  edit,
  disabled,
}

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    super.key, 
    this.title, 
    this.value, 
    this.type = CustomTextfieldType.normal, 
    this.controller,
    this.validator,
    this.keyboardType,
    this.enabledBorderColor,
  });

  final String? title;
  final String? value;
  final CustomTextfieldType type;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final Color? enabledBorderColor;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {

  late ValueNotifier<bool> valueIsShown;

  @override
  void initState() {
    valueIsShown = ValueNotifier<bool>((widget.type == CustomTextfieldType.password) ? false : true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///Label Text
          widget.title != null 
              ? Column(
                children: [
                  Text(
                    widget.title.toString(),
                    style: const TextStyle(
                      fontWeight: regular, 
                      fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 12,),
                ],
              ) 
              : const SizedBox(),

          ///Custom TextFormField
          SizedBox(
            // height: 45,
            child: ValueListenableBuilder(
              valueListenable: valueIsShown,
              builder: (context, value, child){
                return TextFormField(
                  controller: widget.controller,
                  enabled: !(widget.type == CustomTextfieldType.disabled),
                  validator: widget.validator,
                  initialValue: widget.value,
                  cursorColor: infoColor,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextStyle(
                    fontWeight: medium,
                    fontSize: 16,
                    color: (widget.type == CustomTextfieldType.disabled) ? primaryLightestColor : Colors.white
                  ),
                  obscureText: !valueIsShown.value,
                  obscuringCharacter: '*',
                  keyboardType: widget.keyboardType,
                  decoration: InputDecoration(
                    errorMaxLines: 2,
                    errorStyle: const TextStyle(
                      color: error2Color
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 20,
                      right: (widget.type == CustomTextfieldType.normal || widget.type == CustomTextfieldType.disabled)
                          ? 20
                          : 0, 
                    ),
                    suffixIcon: (widget.type == CustomTextfieldType.password) 
                        ? IconButton(
                          onPressed: (){
                            valueIsShown.value = !valueIsShown.value;
                          }, 
                          icon: SvgPicture.asset(
                            (!valueIsShown.value) ? 'assets/icon/Eye-Closed.svg' : 'assets/icon/Eye.svg'
                          )
                        )
                        : (widget.type == CustomTextfieldType.edit)
                            ? IconButton(
                              onPressed: (){}, 
                              icon: SvgPicture.asset(
                                'assets/icon/Pencil.svg'
                              )
                            )
                            : null,

                    ///Borders Settings
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: (widget.enabledBorderColor != null) ? widget.enabledBorderColor! : Colors.white
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: infoColor
                      )
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white
                      )
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: error2Color
                      )
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: error2Color
                      )
                    ),
                  ),
                );
              }
            ),
          )
        ],
      ),
    );
  }
}