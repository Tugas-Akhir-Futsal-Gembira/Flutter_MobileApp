import 'package:flutter_application_futsal_gembira/model/penyewaan/menunggu_pembayaran_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/sudah_dibayar_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/transaksi_dibatalkan_model.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';

abstract class AbstractPenyewaanModel{
  AbstractPenyewaanModel({
    required this.fieldName,
    required this.rentDateTime,
    required this.durationInt,
    required this.createdAtDateTime,
  });

  final String fieldName;
  final DateTime rentDateTime;
  final int durationInt;
  final DateTime createdAtDateTime;

  factory AbstractPenyewaanModel.fromJSON(Map<String, dynamic> json, {int? numService}){
    numService ??= GateService.numService;

    switch(numService){
      case 2: {
        
        switch(json['status_bayar']){
          case 'waiting': {
            return MenungguPembayaranModel.fromJSON(json);
          }
          case 'paid': {
            return SudahDibayarModel.fromJSON(json);
          }
          case 'canceled': {
            return TransaksiDibatalkanModel.fromJSON(json);
          }
          default:{
            return TransaksiDibatalkanModel(
              fieldName: 'null', 
              rentDateTime: DateTime(0), 
              durationInt: 0, 
              createdAtDateTime: DateTime(0)
            );
          }
        }
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