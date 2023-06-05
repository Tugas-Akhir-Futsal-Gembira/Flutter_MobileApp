import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/payment_method/payment_methods_model.dart';
import 'package:flutter_application_futsal_gembira/screen/pilih_jadwal/widget/metode_pembayaran_modal_bottom.dart';

Future<PaymentMethodsModel?> showMetodePembayaran(BuildContext context, double maxHeight) async{
  return await showModalBottomSheet(
    context: context, 
    constraints: BoxConstraints(
      maxHeight: (668/926) * maxHeight,
    ),
    clipBehavior: Clip.antiAlias,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
    ),
    isScrollControlled: true,
    builder: (context) {

      List<PaymentMethodsModel> listOfTransaction = [
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #1',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #2',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #3',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #4',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #5',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #6',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #7',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #8',
          paymentAdminNominal: 4440,
        ),
        PaymentMethodsModel(
          paymentMethodsId: 1, 
          logo: 'assets/image/Temp/Logo BCA_Putih.png', 
          paymentMethodName: 'BCA #9',
          paymentAdminNominal: 4440,
        ),

      ];

      return MetodePembayaranModalBottom(listPaymentMethod: listOfTransaction);
    },
  );
}