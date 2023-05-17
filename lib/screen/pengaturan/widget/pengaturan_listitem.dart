import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PengaturanListItem extends StatelessWidget {
  const PengaturanListItem({super.key, required this.title, this.assetName, this.onTap});

  final String title;
  final String? assetName;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        ///First Stack: Container and visuals
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: primaryLightestColor),
            color: primaryLightColor,
          ),
          child: Row(
            children: [

              ///First Column: assetName Icon
              Builder(
                builder: (context) {
                  if(assetName == null){
                    return const SizedBox();
                  }
                  return SvgPicture.asset(
                    assetName!,
                    height: 24,
                    width: 24,
                  );
                }
              ),
              const SizedBox(width: 20,),

              ///Second Column: Title text
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: semiBold,
                    fontSize: 14,
                  ),
                ),
              ),

              ///Third Column: Caret-Right icon
              SvgPicture.asset(
                'assets/icon/Caret-Right.svg',
                height: 24,
                width: 24,
              )
            ],
          ),
        ),

        ///Second Stack: Material & InkWell
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(5),
              highlightColor: primaryBaseColor.withOpacity(0.5),
              splashColor: primaryLightestColor.withOpacity(0.5),
            ),
          )
        ),
      ],
    );
  }
}