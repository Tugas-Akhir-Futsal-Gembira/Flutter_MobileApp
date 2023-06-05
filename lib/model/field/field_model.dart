import 'package:flutter_application_futsal_gembira/enum/day_enum.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';

class FieldModel{
  FieldModel({
    required this.id,
    required this.name,
    this.description,
    required this.bookingOpenHour,
    required this.bookingOpenMinute,
    required this.bookingCloseHour,
    required this.bookingCloseMinute,
    this.waktuMulaiMalam,
    required this.harga,
    this.hargaMalam,
    this.daysActive,
    required this.gallery,
  });

  final int id;
  final String name;
  final String? description;
  final int bookingOpenHour;
  final int bookingOpenMinute;
  final int bookingCloseHour;
  final int bookingCloseMinute;
  final int? waktuMulaiMalam;
  final int harga;
  final int? hargaMalam;
  final List<DayEnum>? daysActive;
  final List<String> gallery;

  factory FieldModel.fromJSONListField(Map<String, dynamic> json, {int? numService}) {
    numService ??= GateService.numService;

    switch(numService){
      case 2: {
        return FieldModel(
          id: json['field_id'], 
          name: json['name'], 
          bookingOpenHour: int.parse((json['open'] as String).substring(0,2)), 
          bookingOpenMinute: int.parse((json['open'] as String).substring(3)),
          bookingCloseHour: int.parse((json['close'] as String).substring(0,2)),
          bookingCloseMinute: int.parse((json['close'] as String).substring(3)),
          harga: json['harga'], 
          hargaMalam: json['harga_malam'],
          gallery: [
            json['image']
          ]
        );
      }

      default: {
        return FieldModel(
          id: 0, 
          name: 'null', 
          bookingOpenHour: 0, 
          bookingOpenMinute: 0,
          bookingCloseHour: 0, 
          bookingCloseMinute: 0,
          harga: 0,
          gallery: []
        );
      }
    }
  }
}