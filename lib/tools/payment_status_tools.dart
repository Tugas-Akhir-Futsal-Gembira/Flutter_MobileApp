import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/abstract_penyewaan_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/dibatalkan_admin_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/menunggu_pembayaran_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/sudah_dibayar_model.dart';
import 'package:flutter_application_futsal_gembira/model/penyewaan/transaksi_dibatalkan_model.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';

Color paymentStatusColor(AbstractPenyewaanModel model){
  Map colorMap = {
    SudahDibayarModel : success2Color,
    MenungguPembayaranModel : warningColor,
    TransaksiDibatalkanModel : error2Color,
    DibatalkanAdminModel : greyColor
  };

  return colorMap[model.runtimeType];
}

String paymentStatusString(AbstractPenyewaanModel model){
  Map stringMap = {
    SudahDibayarModel : 'Sudah Dibayar',
    MenungguPembayaranModel : 'Menunggu Pembayaran',
    TransaksiDibatalkanModel : 'Transaksi Dibatalkan',
    DibatalkanAdminModel : 'Dibatalkan Admin',
  };

  return stringMap[model.runtimeType];
}