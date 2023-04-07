import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/enum/day_enum.dart';
import 'package:flutter_application_futsal_gembira/screen/detail_penyewaan_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';

class FieldGridItem extends StatelessWidget {
  FieldGridItem({super.key, required this.name, required this.timeStart, required this.timeEnd, required this.days}){

    String temp = '';

    for(int i = 0; i < days.length; i++){
      temp += days[i].name.sentenceCase;
      if(i < days.length - 1){
        temp += ', ';
      }
    }

    daysFormatted = temp;
  }

  final String name;
  final TimeOfDay timeStart;
  final TimeOfDay timeEnd;
  final List<DayEnum> days;
  late final String daysFormatted;

  @override
  Widget build(BuildContext context) {

    NumberFormat numFormat = NumberFormat('00');

    return Stack(
      children: [

        ///The Container, image and more
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: primaryLightestColor),
            color: primaryLightColor
          ),
          child: Column(
            children: [

              AspectRatio(
                aspectRatio: 1/1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    ///DecorationImage
                    image: DecorationImage(
                      image: AssetImage('assets/image/Lapangan futsal wallpaper.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Color(0x66363636), BlendMode.srcATop)
                    )
                  ),

                  
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      ///Days
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xE42F2F2F),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text(
                          daysFormatted,
                          style: TextStyle(
                            fontWeight: medium,
                            fontSize: 10
                          ),
                        ),
                      ),

                      ///Hours
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xE42F2F2F),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //10:00 - 21:00
                                '${numFormat.format(timeStart.hour)}:${numFormat.format(timeStart.minute)} - ${numFormat.format(timeEnd.hour)}:${numFormat.format(timeEnd.minute)}',
                                style: TextStyle(
                                  fontWeight: medium,
                                  fontSize: 10
                                ),
                              ),
                              const SizedBox(width: 6,),
                              SvgPicture.asset('assets/icon/Clock-2.svg'),
                            ],
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///Name
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name,
                            style: TextStyle(
                              fontWeight: semiBold,
                              fontSize: 14
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset('assets/icon/Caret-Right.svg'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        ///InkWell
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
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