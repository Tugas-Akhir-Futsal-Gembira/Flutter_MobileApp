import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';

class TransaksiDibatalkanModel extends AbstractPenyewaanModel{
  TransaksiDibatalkanModel({
    required super.fieldName, 
    required super.rentDateTime, 
    required super.durationInt, 
    required super.createdAtDateTime,
    this.paymentDueDateTime,
  });

  final DateTime? paymentDueDateTime;
}