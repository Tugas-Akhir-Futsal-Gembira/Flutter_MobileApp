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
    this.waktuMulaiMalamHour,
    this.waktuMulaiMalamMinute,
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
  final int? waktuMulaiMalamHour;
  final int? waktuMulaiMalamMinute;
  final int harga;
  final int? hargaMalam;
  final List<String>? daysActive;
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

  factory FieldModel.fromJSONDetailField(Map<String, dynamic> json, int id, {int? numService}) {
    numService ??= GateService.numService;

    switch(numService){
      case 2: {
        return FieldModel(
          id: id, 
          name: json['name'], 
          bookingOpenHour: int.parse((json['booking_open'] as String).substring(0,2)), 
          bookingOpenMinute: int.parse((json['booking_open'] as String).substring(3, 5)),
          bookingCloseHour: int.parse((json['booking_close'] as String).substring(0,2)),
          bookingCloseMinute: int.parse((json['booking_close'] as String).substring(3, 5)),
          description: json['description'],
          harga: json['harga'], 
          hargaMalam: json['harga_malam'],
          waktuMulaiMalamHour: (json['waktu_mulai_malam'] != null)
              ? int.tryParse((json['waktu_mulai_malam'] as String).substring(0,2))
              : null,
          waktuMulaiMalamMinute: (json['waktu_mulai_malam'] != null)
              ? int.tryParse((json['waktu_mulai_malam'] as String).substring(3,5))
              : null,
          daysActive: (json['days_active'] as List).map((e) {
            return e['day_name'] as String;
          }).toList(),
          gallery: (json['galleries'] as List).map((e) {
            return e['image'].toString();
          }).toList()
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