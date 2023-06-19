import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';

class BiayaSewa extends StatelessWidget {
  const BiayaSewa({
    super.key,
    this.fieldDayPrice,
    this.fieldNightPrice,
    this.adminPricePercent,
    this.adminPriceNominal,
    this.adminPricePercentCalculated,
    this.totalPrice,
    this.durationDay,
    this.durationNight,
    this.debugColor = false,
  });

  ///Input of field price (day)
  final int? fieldDayPrice;

  ///Input of field price (night)
  final int? fieldNightPrice;

  ///Input of admin price of midtrans payment (nominal/fixed)
  ///
  ///Must choose one of three adminPrice parameter
  final int? adminPriceNominal;

  ///Input of admin price of midtrans payment (percentage)
  ///
  ///Must choose one of three adminPrice parameter
  final int? adminPricePercent;

  ///Input of admin price of midtrans pament (percantage but already calculated)
  ///
  ///Must choose one of three adminPrice parameter
  final int? adminPricePercentCalculated;

  ///Input of duration for day
  final int? durationDay;

  ///Input of duration for night
  final int? durationNight;

  ///Automaticaly calculate total price if this was null
  final int? totalPrice;

  ///On/Off color for debugging
  final bool debugColor;

  @override
  Widget build(BuildContext context) {

    ///throw error
    if(fieldDayPrice == null && fieldNightPrice == null){
      throw const FormatException('both fieldDayPrice or fieldNightPrice can not be null ');
    }
    else if(durationDay == null && durationNight == null){
      throw const FormatException('both durationDay or durationNight can not be null ');
    }

    final List<int?> adminPriceList = [
      adminPriceNominal, adminPricePercent, adminPricePercentCalculated
    ];
    ///Count++ if any item in adminPriceList is not null
    int adminTypeNullCount = 0;
    for (var element in adminPriceList) {
      if(element != null){
        adminTypeNullCount += 1;
      }
    }
    if(adminTypeNullCount == 0){
      throw const FormatException('adminPrice can not be null. One of three adminPrice need to be inputed');
    }
    else if(adminTypeNullCount > 1){
      throw const FormatException('adminPrice can only be inputed for one of the three');
    }



    const TextStyle firstRow = TextStyle(fontWeight: medium, fontSize: 12);
    const TextStyle nonFirstRow = TextStyle(fontWeight: regular, fontSize: 12);

    ///day price * duration day (null if day price = null and (day duration = null or day duration = 0))
    final int? totalPriceDay = (fieldDayPrice != null && (durationDay != null && durationDay != 0))
        ? fieldDayPrice! * durationDay!
        : null;

    ///day night * duration day (null if night price = null and (night duration = null or night duration = 0))
    final int? totalPriceNight = (fieldNightPrice != null && (durationNight != null && durationNight != 0))
        ? fieldNightPrice! * durationNight!
        : null;

    ///total price without admin
    final int totalPriceBeforeAdmin = (totalPrice != null) 
        ? totalPrice! 
        : ((totalPriceDay != null) ? totalPriceDay : 0) + ((totalPriceNight != null) ? totalPriceNight : 0);
    
    ///Calculate admin price
    final int totalAdminPrice = (adminPriceNominal != null)
        ? adminPriceNominal!
        : (adminPricePercentCalculated != null)
            ? adminPricePercentCalculated!
            : (adminPricePercent != null)
                ?(totalPriceBeforeAdmin * (adminPricePercent! / 100)).round()
                : 0;

    ///Will not calculate if totalPrice is not null
    final int totalPriceTotalCalculated = (totalPrice != null) 
        ? totalPrice! 
        : totalPriceBeforeAdmin + totalAdminPrice;



    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryLightColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: primaryLightestColor)
      ),
      child: Column(
        children: [

          ///First Row
          Row(
            children: [
              Container(
                color: (debugColor) ? Colors.red : Colors.transparent,
                width: 100,
                child: const Text(
                  'Deskripsi Barang', 
                  style: firstRow,
                )
              ),
              Expanded(
                child: Container(
                  color: (debugColor) ? Colors.green : Colors.transparent,
                  child: const Text(
                    'Harga Satuan', 
                    style: firstRow, 
                    textAlign: TextAlign.right,
                  )
                ),
              ),
              Container(
                color: (debugColor) ? Colors.brown : Colors.transparent,
                width: 20,
              ),
              Container(
                color: (debugColor) ? Colors.blue : Colors.transparent,
                width: 70,
                child: const Text(
                  'Nilai', 
                  style: firstRow, 
                  textAlign: TextAlign.right,
                )
              ),
            ],
          ),

          const SizedBox(height: 16,),
          
          ///Second Row (Day Price)
          (totalPriceDay == null) 
              ? const SizedBox() 
              : Row(
                children: [
                  Container(
                    color: (debugColor) ? Colors.red : Colors.transparent,
                    width: 100,
                    child: const Text(
                      'Sewa per jam', 
                      style: nonFirstRow,
                    )
                  ),
                  Expanded(
                    child: Container(
                      color: (debugColor) ? Colors.green : Colors.transparent,
                      child: Text(
                        customCurrencyFormat(fieldDayPrice!, withSymbol: true), 
                        style: nonFirstRow, 
                        textAlign: TextAlign.right,
                      )
                    ),
                  ),
                  Container(
                    color: (debugColor) ? Colors.brown : Colors.transparent,
                    width: 20,
                    child: Text(
                      'x$durationDay',
                      style: nonFirstRow,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    color: (debugColor) ? Colors.blue : Colors.transparent,
                    width: 70,
                    child: Text(
                      customCurrencyFormat(totalPriceDay, withSymbol: true), 
                      style: nonFirstRow, 
                      textAlign: TextAlign.right,
                    )
                  ),
                ],
              ),

          (totalPriceDay == null) ? const SizedBox() : const SizedBox(height: 8,),

          ///Third Row (Night Price)
          (totalPriceNight == null) ? 
              const SizedBox() : 
              Row(
                children: [
                  Container(
                    color: (debugColor) ? Colors.red : Colors.transparent,
                    width: 100,
                    child: const Text(
                      'Sewa khusus malam per jam', 
                      style: nonFirstRow,
                    )
                  ),
                  Expanded(
                    child: Container(
                      color: (debugColor) ? Colors.green : Colors.transparent,
                      child: Text(
                        customCurrencyFormat(
                          fieldNightPrice!,
                          withSymbol: (totalPriceDay == null) ? true : false,
                        ), 
                        style: nonFirstRow, 
                        textAlign: TextAlign.right,
                      )
                    ),
                  ),
                  Container(
                    color: (debugColor) ? Colors.brown : Colors.transparent,
                    width: 20,
                    child: Text(
                      'x$durationNight',
                      style: nonFirstRow,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Container(
                    color: (debugColor) ? Colors.blue : Colors.transparent,
                    width: 70,
                    child: Text(
                      customCurrencyFormat(totalPriceNight, withSymbol: (totalPriceDay == null) ? true : false), 
                      style: nonFirstRow, 
                      textAlign: TextAlign.right,
                    )
                  ),
                ],
              ),

          (totalPriceNight == null) ? const SizedBox() : const SizedBox(height: 8,),
          
          ///Forth Row (Admin Price)
          Row(
            children: [
              Container(
                color: (debugColor) ? Colors.red : Colors.transparent,
                width: 100,
                child: const Text(
                  'Biaya Admin', 
                  style: nonFirstRow,
                )
              ),
              Expanded(
                child: Container(
                  color: (debugColor) ? Colors.green : Colors.transparent,
                  child: Text(
                    customCurrencyFormat(adminPriceNominal!, withSymbol: false), 
                    style: nonFirstRow, 
                    textAlign: TextAlign.right,
                  )
                ),
              ),
              Container(
                color: (debugColor) ? Colors.brown : Colors.transparent,
                width: 20,
                child: const Text(
                  'x1',
                  style: nonFirstRow,
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                color: (debugColor) ? Colors.blue : Colors.transparent,
                width: 70,
                child: Text(
                  customCurrencyFormat(
                    adminPriceNominal!, 
                    withSymbol: false
                  ), 
                  style: nonFirstRow, 
                  textAlign: TextAlign.right,
                )
              ),
            ],
          ),

          const SizedBox(height: 32,),
          
          ///Fifth Row (Total Price Calculated)
          Row(
            children: [
              Container(
                color: (debugColor) ? Colors.red : Colors.transparent,
                width: 100,
                child: Text(
                  'Total', 
                  style: nonFirstRow.copyWith(fontWeight: semiBold),
                )
              ),
              Expanded(
                child: Container(
                  color: (debugColor) ? Colors.green : Colors.transparent,
                ),
              ),
              Container(
                color: (debugColor) ? Colors.brown : Colors.transparent,
                width: 20,
              ),
              Container(
                color: (debugColor) ? Colors.blue : Colors.transparent,
                width: 70,
                child: Text(
                  customCurrencyFormat(
                    totalPriceTotalCalculated, 
                    withSymbol: true
                  ), 
                  style: nonFirstRow, 
                  textAlign: TextAlign.right,
                )
              ),
            ],
          ),
        ],
      ),
    );
  }
}