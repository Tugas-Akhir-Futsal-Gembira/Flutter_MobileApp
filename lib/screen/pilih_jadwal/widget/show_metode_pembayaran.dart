import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

void showMetodePembayaran(BuildContext context, double maxHeight) {
  showModalBottomSheet(
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

      List<Map> listOfTransaction = [
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #1',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #1',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #1',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },
        {
          'logo' : 'assets/image/Temp/Logo BCA_Putih.png',
          'name' : 'BCA #2',
          'admin_price' : 4440,
        },

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
                        for(Map i in listOfTransaction)
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
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: AssetImage(i['logo']),
                                      )
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.green,
                                      child: Text(i['name']),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.blue,
                                    width: 80,
                                    child: Text(
                                      '+ Rp ${i['admin_price']}'
                                    ),
                                  )
                                ],
                              ),
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