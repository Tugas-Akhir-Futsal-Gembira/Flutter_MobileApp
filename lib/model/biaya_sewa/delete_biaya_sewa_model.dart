import 'package:flutter_application_futsal_gembira/model/biaya_sewa/delete_biaya_sewa_item_model.dart';

class BiayaSewaModel{
  BiayaSewaModel({
    required this.listBiayaItem,
  }){
    double temp = 0;
    for(BiayaSewaItemModel i in listBiayaItem){
      temp += i.totalUnitPrice;
    }

    totalPrice = temp;
  }

  final List<BiayaSewaItemModel> listBiayaItem;
  late final double totalPrice;
}