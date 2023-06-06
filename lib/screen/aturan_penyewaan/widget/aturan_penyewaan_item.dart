import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class AturanPenyewaanItem extends StatelessWidget {
  const AturanPenyewaanItem({
    super.key, 
    this.title,
    this.value,
    this.value2,
    this.description,
    this.colorDebug = false
  });

  ///For debugging purpose
  final bool colorDebug;

  ///Placed in left side
  final String? title;

  ///Placed in right upper side
  final String? value;

  ///Placed in right bottom side
  final String? value2;

  ///Show modal bottom sheet that contain title and description text when description is not null
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        ///ClipRRect, Backdrop, content and more...
        ClipRRect(
          borderRadius: BorderRadius.circular(5),

          ///Background Blur
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.4, sigmaY: 1.4),

            ///Container
            child: Container(
                constraints: const BoxConstraints(
                minHeight: 81,
              ),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: primaryLightestColor.withOpacity(0.15)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ///First Row: Text title
                  Expanded(
                    child: Text(
                      title.toString(),       //'Durasi minimal penyewaan'
                      style: const TextStyle(fontWeight: regular, fontSize: 16),
                    ),
                  ),
                  const SizedBox(width: 16,),

                  ///Second Row: Text value
                  Container(
                    width: 100,
                    color: (colorDebug) ? Colors.amber : null,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (value == null)
                            ? const SizedBox()
                            : Text(value.toString(), style: const TextStyle(fontWeight: bold, fontSize: 36),),     //'1'
                        (value2 == null)
                            ? const SizedBox()
                            : Text(value2.toString(), style: const TextStyle(fontWeight: bold, fontSize: 16),),     //'Jam'
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),

        ///Material and InkWell
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: (description == null)
                  ? null
                  : () {
                    ///Modal Bottom Sheet
                    showModalBottomSheet(
                      context: context, 
                      backgroundColor: const Color(0x7E000000),
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.all(24),
                          constraints: const BoxConstraints(minHeight: 244),
                          decoration: const BoxDecoration(
                            color: primaryLightColor,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(10))
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title.toString(), style: const TextStyle(fontWeight: semiBold, fontSize: 16),   //'Durasi minimal penyewaan'
                              ),
                              const Divider(color: Colors.white, height: 24, thickness: 1),
                              const SizedBox(height: 16,),

                              Text(
                                description.toString(), style: const TextStyle(fontWeight: regular, fontSize: 16),   //'Durasi minimal penyewaan'
                              ),
                            ],
                          )
                        );
                      },
                    );
                  },
            ),
          ),
        )
      ],
    );
  }
}