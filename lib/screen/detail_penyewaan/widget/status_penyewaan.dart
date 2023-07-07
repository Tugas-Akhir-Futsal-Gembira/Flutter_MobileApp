import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/dibatalkan_admin_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/menunggu_pembayaran_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/sudah_dibayar_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/transaksi_dibatalkan_model.dart';
import 'package:flutter_application_futsal_gembira/screen/detail_cara_bayar/detail_cara_bayar_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_tool.dart';
import 'package:flutter_application_futsal_gembira/tools/payment_status_tools.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatusPenyewaan extends StatelessWidget {
  const StatusPenyewaan({super.key, required this.model, required this.totalPrice});

  final AbstractPenyewaanModel model;
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: primaryLightColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryLightestColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paymentStatusString(model),
              style: TextStyle(
                color: paymentStatusColor(model),
                fontWeight: semiBold,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 16,),
    
            Builder(
              builder: (context) {
    
                const TextStyle titleTextStyle = TextStyle(fontWeight: light, fontSize: 12);
                const TextStyle itemTextStyle = TextStyle(fontWeight: medium, fontSize: 14);
    
                switch(model.runtimeType){
    
                  ///If SudahDibayar
                  case SudahDibayarModel: {
    
                    ValueNotifier<bool> isObscured = ValueNotifier(true);
    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
    
                        ///First Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Metode Pembayaran',
                                    style: titleTextStyle
                                  ),
                                  const SizedBox(height: 2,),
                            
                                  Text(
                                    (model as SudahDibayarModel).paymentMethod.toString(),
                                    style: itemTextStyle
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8,),
    
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Kode Check In',
                                    style: titleTextStyle
                                  ),
                                  const SizedBox(height: 2,),
                            
                                  ValueListenableBuilder(
                                    valueListenable: isObscured,
                                    builder: (context, value, child) {
                                      return Row(
                                        children: [
    
                                          Text(
                                            obscureText(
                                              (model as SudahDibayarModel).checkInCode.toString(),
                                              isObscured: (isObscured.value) ? true : false,
                                            ),
                                            style: itemTextStyle
                                          ),
    
                                          const Spacer(),
    
                                          GestureDetector(
                                            onTap: () => isObscured.value = !isObscured.value,
                                            child: SvgPicture.asset(
                                              (isObscured.value) ? 'assets/icon/Eye-Closed.svg' : 'assets/icon/Eye.svg', 
                                              height: 17, 
                                              width: 17,
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),  ///End of First Row
                        const SizedBox(height: 16,),
    
                        ///Second Row
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tanggal Pembayaran',
                              style: titleTextStyle
                            ),
                            const SizedBox(height: 2,),
                      
                            Text(
                              customDateFormat((model as SudahDibayarModel).paymentDateTime!),
                              style: itemTextStyle.copyWith(fontWeight: semiBold)
                            ),
                          ],
                        ),  ///End of Second Row
                        const SizedBox(height: 8,),
                      ],
                    );
                  }
    
    
    
    
    
                  ///If MenungguPembayaranModel
                  case MenungguPembayaranModel: {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
    
                        ///First Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Metode Pembayaran',
                                    style: titleTextStyle
                                  ),
                                  const SizedBox(height: 2,),
                            
                                  Text(
                                    (model as MenungguPembayaranModel).paymentMethod.toString(),
                                    style: itemTextStyle
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8,),
    
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Batas Pembayaran',
                                    style: titleTextStyle
                                  ),
                                  const SizedBox(height: 2,),
                            
                                  Text(
                                    customDateFormat((model as MenungguPembayaranModel).paymentDueDateTime!),
                                    style: itemTextStyle
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),  ///End of First Row
                        const SizedBox(height: 16,),
    
                        ///Second Row
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Kode Pembayaran',
                              style: titleTextStyle
                            ),
                            const SizedBox(height: 2,),
                      
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: (model as MenungguPembayaranModel).paymentCode));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  CustomSnackbar(title: 'Nomor telah disalin')
                                );
                              },
                              child: Text(
                                (model as MenungguPembayaranModel).paymentCode!,
                                style: const TextStyle(fontWeight: semiBold, fontSize: 16, decoration: TextDecoration.underline)
                              ),
                            ),
                          ],
                        ),  ///End of Second Row
    
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(builder: (context) => DetailCaraBayarScreen(
                                paymentMethodId: (model as MenungguPembayaranModel).paymentMethodId!,
                                paymentMethodName: (model as MenungguPembayaranModel).paymentMethod!,
                                totalPrice: totalPrice,
                                paymentCode: (model as MenungguPembayaranModel).paymentCode!,
                                paymentDueDateTime: (model as MenungguPembayaranModel).paymentDueDateTime!,
                              ),)
                            );
                          },
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Lihat cara bayar',
                              style: TextStyle(fontWeight: regular, fontSize: 12, decoration: TextDecoration.underline),
                            ),
                          ),
                        )
                      ],
                    );
                  }
    
    
    
    
    
    
    
                  ///If TransaksiDibatalkan
                  case TransaksiDibatalkanModel: {
                    return SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Batas Pembayaran',
                            style: titleTextStyle
                          ),
                          const SizedBox(height: 2,),
                                    
                          Text(
                            customDateFormat((model as TransaksiDibatalkanModel).paymentDueDateTime!),
                            style: itemTextStyle
                          ),
                          const SizedBox(height: 48,)
                        ],
                      ),
                    );
                  }
    

                  


                  ///If DibatalkanAdmin
                  case DibatalkanAdminModel: {

                    late String statusSebelumnyaString;
                    late Color statusSebelumnyaColor;

                    ///If statusPrevious is Sudah Dibayar
                    if((model as DibatalkanAdminModel).statusPrevious == 'paid'){
                      statusSebelumnyaString = 'Sudah Dibayar';
                      statusSebelumnyaColor = success2Color;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      
                          ///First Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Status Sebelumnya',
                                      style: titleTextStyle
                                    ),
                                    const SizedBox(height: 2,),
                              
                                    Text(
                                      statusSebelumnyaString.toString(),
                                      style: itemTextStyle.copyWith(color: statusSebelumnyaColor)
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8,),
      
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tanggal Pembayaran',
                                      style: titleTextStyle
                                    ),
                                    const SizedBox(height: 2,),
                              
                                    Text(
                                      customDateFormat((model as DibatalkanAdminModel).paymentDateTime!),
                                      style: itemTextStyle
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),  ///End of First Row
                          const SizedBox(height: 16,),
      
                          ///Second Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Metode Pembayaran',
                                      style: titleTextStyle
                                    ),
                                    const SizedBox(height: 2,),
                              
                                    Text(
                                      (model as DibatalkanAdminModel).paymentMethod.toString(),
                                      style: itemTextStyle
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8,),
      
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tanggal Dibatalkan Admin',
                                      style: titleTextStyle
                                    ),
                                    const SizedBox(height: 2,),
                              
                                    Text(
                                      customDateFormat((model as DibatalkanAdminModel).canceledDateTime!),
                                      style: itemTextStyle
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),  ///End of Second Row
                          const SizedBox(height: 8,),
                        ],
                      );
                    }



                    ///If statusPrevious is Transaksi Dibatalkan
                    else if((model as DibatalkanAdminModel).statusPrevious == 'canceled'){
                      statusSebelumnyaString = 'Transaksi Dibatalkan';
                      statusSebelumnyaColor = error2Color;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
      
                          ///First Row
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Status Sebelumnya',
                                      style: titleTextStyle
                                    ),
                                    const SizedBox(height: 2,),
                              
                                    Text(
                                      statusSebelumnyaString.toString(),
                                      style: itemTextStyle.copyWith(color: statusSebelumnyaColor)
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8,),
      
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Tanggal Dibatalkan Admin',
                                      style: titleTextStyle
                                    ),
                                    const SizedBox(height: 2,),
                              
                                    Text(
                                      customDateFormat((model as DibatalkanAdminModel).canceledDateTime!),
                                      style: itemTextStyle
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),  ///End of First Row
                          const SizedBox(height: 16,),
      
                          ///Second Row
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Batas Pembayaran',
                                style: titleTextStyle
                              ),
                              const SizedBox(height: 2,),
                          
                              Text(
                                customDateFormat((model as DibatalkanAdminModel).paymentDueDateTime!),
                                style: itemTextStyle
                              ),
                            ],
                          ),  ///End of Second Row
                          const SizedBox(height: 8,),
                        ],
                      );
                    }
                    else{
                      statusSebelumnyaString = 'null';
                      statusSebelumnyaColor = Colors.white;

                      return const SizedBox();
                    }
                  }


    
    
                  default: {
                    return const SizedBox();
                  }
                }
              },
            )
    
    
          ],
        ),
      ),
    );
  }
}