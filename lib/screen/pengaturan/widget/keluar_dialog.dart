import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';

void keluarDialog(BuildContext context){

  showDialog(
    context: context, 
    builder: (context) => AlertDialog(
      shadowColor: Colors.black.withOpacity(0.5),
      backgroundColor: primaryLightColor,
      contentPadding: const EdgeInsets.all(32),
      actionsPadding: const EdgeInsets.only(right: 12, left: 12, bottom: 12),

      ///Content
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ///First Row: Logout icon
          SvgPicture.asset(
            'assets/icon/Logout.svg',
            height: 109,
            width: 109,
          ),
          const SizedBox(height: 16,),

          ///Second Row: 'Keluar' text
          const Text(
            'Keluar',
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8,),

          ///Third Row: Confirmation text
          const Text(
            'Apakah anda yakin ingin keluar',
            style: TextStyle(
              fontWeight: regular,
              fontSize: 16,
            ),
          ),

        ],
      ),

      ///Actions
      actions: [
        Row(
          children: [

            ///First Column: No Button
            Flexible(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: primaryLightestColor),
                    ),
                    child: const Text(
                      'Tidak',
                      style: TextStyle(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(5),
                        highlightColor: primaryBaseColor.withOpacity(0.5),
                        splashColor: primaryLightestColor.withOpacity(0.5),
                      ),
                    )
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12,),
            
            ///Second Column: Yes Button
            Flexible(
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: error2Color
                    ),
                    child: const Text(
                      'Ya',
                      style: TextStyle(
                        fontWeight: semiBold,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async{
                          await MySharedPreferences.remove(MySharedPreferences.accessTokenKey);
                          SystemNavigator.pop();
                        },
                        borderRadius: BorderRadius.circular(5),
                        highlightColor: primaryBaseColor.withOpacity(0.5),
                        splashColor: primaryLightestColor.withOpacity(0.5),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}