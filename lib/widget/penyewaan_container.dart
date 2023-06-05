import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/screen/detail_penyewaan/detail_penyewaan_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/tools/payment_status_tools.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_dot.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PenyewaanContainer extends StatelessWidget {
  const PenyewaanContainer({
    super.key,
    required this.abstractPenyewaanModel,
    this.customMessage,
    this.transparentBackground = false,
  });

  final AbstractPenyewaanModel abstractPenyewaanModel;
  final String? customMessage;
  final bool transparentBackground;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [

          ///The Container with BackdropFilter(blur background)(not the InkWell)
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: (transparentBackground) ? 1.4 : 0, 
                sigmaY: (transparentBackground) ? 1.4 : 0,
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: (transparentBackground) 
                      ? primaryLightestColor.withOpacity(0.15)
                      : primaryLightColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
              
                    ///First Row
                    Row(
                      children: [
                        SvgPicture.asset('assets/icon/mdi_soccer-field.svg'),
                        const SizedBox(width: 12,),
                        Expanded(
                          child: Text(
                            abstractPenyewaanModel.fieldName,
                            style: const TextStyle(
                              fontWeight: medium,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SvgPicture.asset('assets/icon/Caret-Right.svg'),
                      ],
                    ),
                    const SizedBox(height: 12,),
              
                    ///Second Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        ///Tanggal & Waktu Sewa
                        Container(
                          padding: const EdgeInsets.only(right: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tanggal & Waktu Sewa',
                                style: TextStyle(
                                  fontWeight: light,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                customDateFormat(abstractPenyewaanModel.rentDateTime),
                                style: const TextStyle(
                                  fontWeight: medium,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
              
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const CustomDot(size: 5, color: Colors.white,)
                        ),
              
                        ///Durasi Sewa
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Durasi Sewa',
                                style: TextStyle(
                                  fontWeight: light,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 2,),
                              Text(
                                '${abstractPenyewaanModel.durationInt} Jam',
                                style: const TextStyle(
                                  fontWeight: medium,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
              
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const CustomDot(size: 5, color: Colors.white,)
                        ),
              
                        ///Status
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.only(left: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Status',
                                  style: TextStyle(
                                    fontWeight: light,
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(height: 2,),
                                Text(
                                  paymentStatusString(abstractPenyewaanModel),
                                  style: TextStyle(
                                    fontWeight: semiBold,
                                    fontSize: 12,
                                    color: paymentStatusColor(abstractPenyewaanModel)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
              
                    ///Third Row
                    Align(
                      alignment: (customMessage == null) ? Alignment.centerLeft : Alignment.centerRight,
                      child: Text(
                        (customMessage == null) ? 
                            'Dibuat pada tanggal ${customDateFormat(abstractPenyewaanModel.createdAtDateTime)}' :
                            customMessage!,
                        style: const TextStyle(
                          fontWeight: light,
                          fontStyle: FontStyle.italic,
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          ///The InkWell
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const DetailPenyewaanScreen(),)
                  );
                },
                borderRadius: BorderRadius.circular(5),
                highlightColor: primaryBaseColor.withOpacity(0.5),
                splashColor: primaryLightestColor.withOpacity(0.5)
              ),
            )
          )
        ],
      ),
    );
  }
}