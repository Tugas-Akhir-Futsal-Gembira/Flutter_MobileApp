import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeContainer extends StatelessWidget {
  const WelcomeContainer({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: primaryLightestColor
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ///First Row
          Row(
            children: [
              SvgPicture.asset('assets/icon/beranda/ion_football.svg'),
              const SizedBox(width: 12,),
              Expanded(
                //Hi Futsal Lovers Chandra12345678900000000000000123
                child: Text(
                  'Hi Futsal Lovers $name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: medium, 
                    fontSize: 20
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12,),

          ///Second Row
          Text(
            'Anda belum menyewa lapangan futsal, yuk ajak teman teman $name main futsal agar kalian bisa tetap kompak dan akrab',
            style: const TextStyle(
              fontWeight: regular,
              fontSize: 14
            ),
          ),
          const SizedBox(height: 12,),

          ///Third Row
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Yuk pick lapangan dibawah ini',
              style: TextStyle(
                fontWeight: light,
                fontStyle: FontStyle.italic,
                fontSize: 10
              ),
            ),
          )
        ],
      ),
    );
  }
}