import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';

class MenungguPembayaranModel extends AbstractPenyewaanModel{
  MenungguPembayaranModel({
    required super.id,
    required super.fieldName, 
    required super.rentDateTime, 
    required super.durationInt, 
    required super.createdAtDateTime,
    this.paymentMethod,
    this.paymentMethodId,
    this.paymentDueDateTime,
    this.paymentCode,
  });

  final String? paymentMethod;
  final int? paymentMethodId;
  final DateTime? paymentDueDateTime;
  final String? paymentCode;

  factory MenungguPembayaranModel.fromJSON(Map<String, dynamic> json, {int? bookingId, int? numService}){
    numService ??= GateService.numService;

    switch(numService){
      case 2: {
        DateTime rentDateTime = customJsonToDateTime( json['booking_date_time'] );
        DateTime createdAtDateTime = customJsonToDateTime( json['created_at'] );
        DateTime paymentDueDateTime = customJsonToDateTime( json['tanggal_batas_pembayaran'] );

        return MenungguPembayaranModel(
          id: (json['booking_id'] != null) ? json['booking_id'] : bookingId,
          fieldName: (json['name'] != null) ? json['name'] : json['field_name'], 
          rentDateTime: rentDateTime, 
          durationInt: json['duration'], 
          createdAtDateTime: createdAtDateTime,
          paymentCode: json['virtual_account_code'],
          paymentDueDateTime: paymentDueDateTime,
          paymentMethod: json['booking_payment_method_name'],
          paymentMethodId: json['payment_method_id'],
        );

      }

      default: {
        return MenungguPembayaranModel(
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