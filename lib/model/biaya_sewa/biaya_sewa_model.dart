import 'package:flutter_application_futsal_gembira/service/gate_service.dart';

class BiayaSewaModel{
  BiayaSewaModel({
    this.dayPrice,
    this.nightPrice,
    this.adminPrice,
    this.dayPriceQuantity,
    this.nightPriceQuantity,
    this.totalPrice,
  });

  final int? dayPrice;
  final int? nightPrice;
  final int? adminPrice;
  final int? dayPriceQuantity;
  final int? nightPriceQuantity;
  final int? totalPrice;

  factory BiayaSewaModel.fromJSON(Map<String, dynamic> json, {int? numService}){
    numService ??= GateService.numService;

    switch(numService){
      case 2: {
        return BiayaSewaModel(
          dayPrice: json['day_price'],
          nightPrice: json['night_price'],
          adminPrice: json['admin_price'],
          dayPriceQuantity: json['day_price_quantity'],
          nightPriceQuantity: json['night_price_quantity'],
          totalPrice: json['total_price'],
        );
      }

      default: {
        return BiayaSewaModel();
      }
      
    }


  }
}