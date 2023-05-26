import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);

class CustomSnackbar extends SnackBar{
  CustomSnackbar({
    super.key, 
    required this.title, 
    this.duration = _snackBarDisplayDuration,
  }) : super(
    duration: duration,
    backgroundColor: primaryBaseColor,
    padding: const EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(
        color: success2Color,
        style: BorderStyle.solid,
        width: 3,
      )
    ),
    showCloseIcon: true,
    closeIconColor: success2Color,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    content: Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: semiBold,
          fontSize: 16,
        ),
      ),
    ),
  );

  final String title;

  @override
  // ignore: overridden_fields
  final Duration duration;

}

// class CustomSnackbar extends StatelessWidget {
//   const CustomSnackbar({super.key, required this.title, this.duration});

//   final String title;
//   final Duration? duration;

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       duration: (duration != null) ? duration! : const Duration(seconds: 4),
//       backgroundColor: primaryBaseColor,
//       padding: const EdgeInsets.only(top: 0, bottom: 0, left: 24, right: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(
//           color: success2Color,
//           style: BorderStyle.solid,
//           width: 3,
//         )
//       ),
//       showCloseIcon: true,
//       closeIconColor: success2Color,
//       behavior: SnackBarBehavior.floating,
//       margin: const EdgeInsets.all(16),
//       content: Container(
//         alignment: Alignment.centerLeft,
//         height: 65,
//         child: Text(
//           title,
//           style: TextStyle(
//             fontWeight: semiBold,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }