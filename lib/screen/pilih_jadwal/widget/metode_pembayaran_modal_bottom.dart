import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/payment_method/payment_methods_model.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';

class MetodePembayaranModalBottom extends StatefulWidget {
  const MetodePembayaranModalBottom({super.key, required this.listPaymentMethod});

  final List<PaymentMethodsModel> listPaymentMethod;

  @override
  State<MetodePembayaranModalBottom> createState() => _MetodePembayaranModalBottomState();
}

class _MetodePembayaranModalBottomState extends State<MetodePembayaranModalBottom> {

  ValueNotifier<bool> isLoadingValueNotifier = ValueNotifier(false);
  List<PaymentMethodsModel>? listPaymentMethod;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryLightColor,
      padding: const EdgeInsets.only(top: 32),
      width: double.infinity,
      child: ValueListenableBuilder(
        valueListenable: isLoadingValueNotifier,
        builder: (context, value, child) {
          if(isLoadingValueNotifier.value == true){
            return const FittedBox(
              fit: BoxFit.none,
              child: CircularProgressIndicator(
                backgroundColor: infoColor, color: Colors.white,
              ),
            );
          }
          else{
            return child!;
          }
        },
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

                    Builder(
                      builder: (context) {
                        return Column(
                          children: [
                            for(PaymentMethodsModel i in listPaymentMethod!)
                                
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
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            child: Container(
                                              width: 100,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                image: DecorationImage(
                                                  image: NetworkImage(i.logo),
                                                  fit: BoxFit.contain
                                                )
                                              ),
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
                        );
                      }
                    ),
                  ],
                ),
              ),
            )

          ],
        ),
        
      ),
    );
  }

  Future<void> refresh() async{
    isLoadingValueNotifier.value = true;

    // await Future.delayed(const Duration(seconds: 1));
    JSONModel json = await GateService.getListPayment();
    
    if(json.statusCode == 200){
      listPaymentMethod = (json.data as List).map((e) {
        return PaymentMethodsModel.fromJSON(e as Map<String, dynamic>);
      }).toList();
    }
    else if (context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackbar(title: json.getErrorToString(), color: error2Color,)
      );
      Navigator.pop(context);
    }

    isLoadingValueNotifier.value = false;
  }
}