import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';

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
  
}