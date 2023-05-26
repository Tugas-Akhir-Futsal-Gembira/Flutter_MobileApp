import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';

class MenungguPembayaranModel extends AbstractPenyewaanModel{
  MenungguPembayaranModel({
    required super.fieldName, 
    required super.rentDateTime, 
    required super.durationInt, 
    required super.createdAtDateTime,
    this.paymentMethod,
    this.paymentDueDateTime,
    this.paymentCode,
  });

  final String? paymentMethod;
  final DateTime? paymentDueDateTime;
  final String? paymentCode;

}