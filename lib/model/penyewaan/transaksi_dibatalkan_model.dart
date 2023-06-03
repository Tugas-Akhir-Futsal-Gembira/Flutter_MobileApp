import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';

class TransaksiDibatalkanModel extends AbstractPenyewaanModel{
  TransaksiDibatalkanModel({
    required super.fieldName, 
    required super.rentDateTime, 
    required super.durationInt, 
    required super.createdAtDateTime,
    this.paymentDueDateTime,
  });

  final DateTime? paymentDueDateTime;

  factory TransaksiDibatalkanModel.fromJSON(Map<String, dynamic> json, {int? numService}){
    numService ??= GateService.numService;

    switch(numService){
      case 2: {
        DateTime rentDateTime = customJsonToDateTime( json['booking_date_time'] );
        DateTime createdAtDateTime = customJsonToDateTime( json['created_at'] );
        DateTime paymentDueDateTime = customJsonToDateTime( json['tanggal_batas_pembayaran'] );

        return TransaksiDibatalkanModel(
          fieldName: json['name'], 
          rentDateTime: rentDateTime, 
          durationInt: json['duration'], 
          createdAtDateTime: createdAtDateTime,
          paymentDueDateTime: paymentDueDateTime,
        );

      }

      default: {
        return TransaksiDibatalkanModel(
          fieldName: 'null', 
          rentDateTime: DateTime(0), 
          durationInt: 0, 
          createdAtDateTime: DateTime(0)
        );
      }
    }
  }
}