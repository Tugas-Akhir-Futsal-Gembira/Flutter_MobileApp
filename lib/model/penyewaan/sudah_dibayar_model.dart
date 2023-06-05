import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';

class SudahDibayarModel extends AbstractPenyewaanModel{
  SudahDibayarModel({
    required super.fieldName, 
    required super.rentDateTime, 
    required super.durationInt, 
    required super.createdAtDateTime,
    this.paymentMethod,
    this.paymentDateTime,
    this.checkInCode,
  });

  final String? paymentMethod;
  final DateTime? paymentDateTime;
  final String? checkInCode;
  
  factory SudahDibayarModel.fromJSON(Map<String, dynamic> json, {int? numService}){
    numService ??= GateService.numService;

    switch(numService){
      case 2: {
        DateTime rentDateTime = customJsonToDateTime( json['booking_date_time'] );
        DateTime createdAtDateTime = customJsonToDateTime( json['created_at'] );
        DateTime paymentDateTime = customJsonToDateTime( json['tanggal_pembayaran'] );

        return SudahDibayarModel(
          fieldName: json['name'], 
          rentDateTime: rentDateTime, 
          durationInt: json['duration'], 
          createdAtDateTime: createdAtDateTime,
          checkInCode: json['verification_code'],
          paymentDateTime: paymentDateTime,
          paymentMethod: 'TEST PAYMENT METHOD - SUDAH DIBAYAR'
        );

      }

      default: {
        return SudahDibayarModel(
          fieldName: 'null', 
          rentDateTime: DateTime(0), 
          durationInt: 0, 
          createdAtDateTime: DateTime(0)
        );
      }
    }

  }
}