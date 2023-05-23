import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/payment_method/payment_methods.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';

Future<PaymentMethods?> showMetodePembayaran(BuildContext context, double maxHeight) async{
  return await showModalBottomSheet(
    context: context, 
    constraints: BoxConstraints(
      maxHeight: (668/926) * maxHeight
    ),
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
    ),
    isScrollControlled: true,
    builder: (context) {

      List<PaymentMethods> listOfTransaction = [
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #1',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #2',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #3',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #4',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #5',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #6',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #7',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #8',
          paymentAdminNominal: 4440,
        ),
        PaymentMethods(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #9',
          paymentAdminNominal: 4440,
        ),

      ];


      return Container(
        color: primaryLightColor,
        padding: const EdgeInsets.only(top: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Pilih Metode Pembayaran',
                style: TextStyle(
                  fontWeight: semiBold,
                  fontSize: 20
                ),
              ),
            ),
            
            const SizedBox(height: 25,),

            ///ScrollView
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Virtual Account',
                      style: TextStyle(
                        fontWeight: regular,
                        fontSize: 14
                      ),
                    ),

                    Column(
                      children: [
                        for(PaymentMethods i in listOfTransaction)
                            
                            Stack(
                              children: [

                                ///Container of PaymentItem
                                Container(
                                  height: 51,
                                  clipBehavior: Clip.antiAlias,
                                  margin: const EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    color: primaryLightColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: primaryLightestColor),
                                  ),
                                  child: Row(
                                    children: [

                                      ///ImageLogo
                                      Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                          // color: Colors.red,
                                          image: DecorationImage(
                                            image: AssetImage(i.logo),
                                          )
                                        ),
                                      ),

                                      ///Name
                                      Expanded(
                                        child: SizedBox(
                                          // color: Colors.green,
                                          child: Text(i.paymentMethodName),
                                        ),
                                      ),

                                      ///AdminPrice
                                      SizedBox(
                                        // color: Colors.blue,
                                        width: 85,
                                        child: Text(
                                          '+ ${customCurrencyFormat(i.paymentAdminNominal!, decimalDigits: 0)}',
                                        ),
                                      )
                                    ],
                                  ),
                                ),

                                ///InkWell
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context, i);
                                        },
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                      ],
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
      );
    },
  );
}