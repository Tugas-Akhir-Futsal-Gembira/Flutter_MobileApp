import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/enum/day_enum.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/field_griditem.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class FieldGridView extends StatelessWidget {
  const FieldGridView({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Yuk $name main futsal...',
            style: TextStyle(
              fontWeight: medium,
              fontSize: 20
            ),
          ),
        ),
        const SizedBox(height: 12,),

        GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 186/230,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FieldGridItem(
              name: 'Lapangan #1', 
              timeStart: const TimeOfDay(hour: 10, minute: 00), 
              timeEnd: const TimeOfDay(hour: 21, minute: 00), 
              days: [
                DayEnum.values[0],
                DayEnum.values[1],
                DayEnum.values[2],
                DayEnum.values[3],
                DayEnum.values[4],
                DayEnum.values[5],
                DayEnum.values[6],
              ]
            ),
            
            FieldGridItem(
              name: 'Lapangan #2', 
              timeStart: const TimeOfDay(hour: 10, minute: 00), 
              timeEnd: const TimeOfDay(hour: 21, minute: 00), 
              days: [
                DayEnum.values[0],
                DayEnum.values[1],
                DayEnum.values[2],
                DayEnum.values[3],
                DayEnum.values[4],
                DayEnum.values[5],
                DayEnum.values[6],
              ]
            ),

            FieldGridItem(
              name: 'Lapangan #3', 
              timeStart: const TimeOfDay(hour: 10, minute: 00), 
              timeEnd: const TimeOfDay(hour: 21, minute: 00), 
              days: [
                DayEnum.values[0],
                DayEnum.values[1],
                DayEnum.values[2],
                DayEnum.values[3],
                DayEnum.values[4],
                DayEnum.values[5],
                DayEnum.values[6],
              ]
            ),

            FieldGridItem(
              name: 'Lapangan #4', 
              timeStart: const TimeOfDay(hour: 10, minute: 00), 
              timeEnd: const TimeOfDay(hour: 21, minute: 00), 
              days: [
                DayEnum.values[0],
                DayEnum.values[1],
                DayEnum.values[2],
                DayEnum.values[3],
                DayEnum.values[4],
                DayEnum.values[5],
                DayEnum.values[6],
              ]
            ),
          ],
        )
      ],
    );
  }
}