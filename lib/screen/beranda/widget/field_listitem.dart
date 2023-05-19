import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/detail_lapangan_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recase/recase.dart';

class FieldGridItem extends StatelessWidget {
  const FieldGridItem({
    super.key, 
    required this.name, 
    required this.timeHourStart, 
    required this.timeMinuteStart,
    required this.timeHourEnd,
    required this.timeMinuteEnd,
  });

  final String name;
  final int timeHourStart;
  final int timeMinuteStart;
  final int timeHourEnd;
  final int timeMinuteEnd;
  

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        ///The Container, image and more
        Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: const DecorationImage(
              image: AssetImage('assets/image/Lapangan futsal wallpaper.jpg'),
              fit: BoxFit.cover,
            )
          ),

          ///Black box on the bottom with Field Name and Time Start - End
          child: Container(
            height: 43,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(5)),
              color: Colors.black.withOpacity(0.65),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///'Lapangan #1'
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontWeight: semiBold,
                      fontSize: 16,
                    ),
                  ),
                ),

                Expanded(
                  child: Row(
                    children: [
                      
                      ///Icon clock
                      SvgPicture.asset(
                        'assets/icon/Clock-2.svg',
                        height: 18,
                        width: 18,
                      ),
                
                      const SizedBox(width: 8,),
                
                      ///'10:00 - 21:00'
                      Text(
                        '${customTimeFormat(timeHourStart, timeMinuteStart)} - ${customTimeFormat(timeHourEnd, timeMinuteEnd)}',
                        style: const TextStyle(
                          fontWeight: regular,
                          fontSize: 14,
                        ),
                      ),

                      const Spacer(),

                      ///Icon Right Arrow
                      SvgPicture.asset(
                        'assets/icon/Caret-Right.svg',
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ),

        ///InkWell
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailPenyewaanScreen(),));
            },
            highlightColor: primaryBaseColor.withOpacity(0.5),
            splashColor: primaryLightestColor.withOpacity(0.5)
          ),
        )
      ],
    );
  }
}