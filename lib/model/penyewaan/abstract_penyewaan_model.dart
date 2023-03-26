import 'package:flutter_application_futsal_gembira/model/biaya_sewa/biaya_sewa_model.dart';

abstract class AbstractPenyewaanModel{
  AbstractPenyewaanModel({
    required this.fieldName,
    required this.rentDateTime,
    required this.durationInt,
    required this.createdAtDateTime,
    this.biayaSewaModel,
  });

  final String fieldName;
  final DateTime rentDateTime;
  final int durationInt;
  final DateTime createdAtDateTime;
  BiayaSewaModel? biayaSewaModel;
}