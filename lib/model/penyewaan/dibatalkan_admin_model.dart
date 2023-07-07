import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';

class DibatalkanAdminModel extends AbstractPenyewaanModel{
  DibatalkanAdminModel({
    required super.id, 
    required super.fieldName, 
    required super.rentDateTime, 
    required super.durationInt, 
    required super.createdAtDateTime,
    this.statusPrevious,
    this.paymentMethod,
    this.paymentDateTime,
    this.paymentDueDateTime,
    this.canceledDateTime,
  });

  ///'paid' or 'canceled'
  final String? statusPrevious;
  final String? paymentMethod;
  final DateTime? paymentDateTime;
  final DateTime? paymentDueDateTime;
  final DateTime? canceledDateTime;

  factory DibatalkanAdminModel.fromJSON(Map<String, dynamic> json, {int? bookingId, int? numService}){
    numService ??= GateService.numService;

    switch(numService){
      case 2:{
        DateTime rentDateTime = customJsonToDateTime( json['booking_date_time'] );
        DateTime createdAtDateTime = customJsonToDateTime( json['created_at'] );
        DateTime? paymentDateTime = customJsonToDateTime( json['tanggal_pembayaran'] );
        DateTime? paymentDueDateTime = customJsonToDateTime( json['tanggal_batas_pembayaran'] );
        DateTime? canceledDateTime = customJsonToDateTime( json['updated_at'] ); 
        String? statusPrevious = (json['status_previous'] == 'waiting') ? 'canceled' : json['status_previous'];

        return DibatalkanAdminModel(
          id: (json['booking_id'] != null) ? json['booking_id'] : bookingId, 
          fieldName: (json['name'] != null) ? json['name'] : json['field_name'], 
          rentDateTime: rentDateTime, 
          durationInt: json['duration'], 
          createdAtDateTime: createdAtDateTime,
          statusPrevious: statusPrevious,
          paymentMethod: json['booking_payment_method_name'],
          paymentDateTime: paymentDateTime,
          paymentDueDateTime: paymentDueDateTime,
          canceledDateTime: canceledDateTime
        );
      }

      default: {
        return DibatalkanAdminModel(
          id: 0,
          fieldName: 'null', 
          rentDateTime: DateTime(0), 
          durationInt: 0, 
          createdAtDateTime: DateTime(0)
        );
      }
    }
  }
}