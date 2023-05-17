import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';

class CustomAlertDialog extends AlertDialog {
  CustomAlertDialog({
    super.key, 
    required this.context,
    this.onPressedFirstButton,
    this.onPressedSecondButton,
    this.backgroundColorFirstButton = Colors.transparent,
    this.backgroundColorSecondButton = Colors.transparent,
    this.borderColorFirstButton,
    this.borderColorSecondButton,
    this.childFirstButton,
    this.childSecondButton,
    this.visibleFirstButton = false,
    this.visibleSecondButton = false,
    super.content,
    super.backgroundColor = primaryLightColor,
  }) : super(
    surfaceTintColor: const Color(0x7D000000), //black.withOpacity(0.5)
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    actionsPadding: (visibleFirstButton || visibleSecondButton) 
        ? const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ) 
        : const EdgeInsets.all(0),
    actions: [
      Row(
        children: [
          
          ///Left Button (2nd Button)
          Expanded(
            child: Visibility(
              visible: visibleSecondButton,
              child: ElevatedButton(
                onPressed: onPressedSecondButton,
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(double.infinity, 48)),
                  backgroundColor: MaterialStatePropertyAll(backgroundColorSecondButton),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: (borderColorSecondButton != null) 
                          ? BorderSide(
                            color: borderColorSecondButton
                          ) 
                          : BorderSide.none,
                    )
                  )
                ),
                child: childSecondButton,
              ),
            )
          ),
          const SizedBox(width: 8,),

          ///Right Button (1st Button)
          Expanded(
            child: Visibility(
              visible: visibleFirstButton,
              child: ElevatedButton(
                onPressed: onPressedFirstButton,
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(double.infinity, 48)),
                  backgroundColor: MaterialStatePropertyAll(backgroundColorFirstButton),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: (borderColorFirstButton != null) 
                          ? BorderSide(
                            color: borderColorFirstButton
                          ) 
                          : BorderSide.none,
                    )
                  )
                ),
                child: childFirstButton,
              ),
            )
          ),
        ],
      ),
    ]
  );

  final BuildContext context;
  final void Function()? onPressedFirstButton;
  final void Function()? onPressedSecondButton;
  final Color backgroundColorFirstButton;
  final Color backgroundColorSecondButton;
  final Color? borderColorFirstButton;
  final Color? borderColorSecondButton;
  final Widget? childFirstButton;
  final Widget? childSecondButton;
  final bool visibleFirstButton;
  final bool visibleSecondButton;
}