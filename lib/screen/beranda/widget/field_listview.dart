import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/field/field_model.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/field_listitem.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class FieldListView extends StatelessWidget {
  const FieldListView({super.key, this.listField, this.isDummy = false});

  final List<FieldModel>? listField;
  final bool isDummy;

  @override
  Widget build(BuildContext context) {
    
    ///If listField not null, add listField to tempListField
    ///Else if isDummy is true, add dummy list to tempListField
    List<FieldModel> tempListField = [];

    if(listField != null){
      tempListField.addAll(listField!);
    }
    else if(isDummy == true){
      tempListField.addAll([
        FieldModel(
          id: 0, 
          name: 'Lapangan #1', 
          bookingOpenHour: 10, 
          bookingOpenMinute: 00, 
          bookingCloseHour: 21, 
          bookingCloseMinute: 00, 
          harga: 0, 
          gallery: []
        ),

        FieldModel(
          id: 0, 
          name: 'Lapangan #2', 
          bookingOpenHour: 10, 
          bookingOpenMinute: 00, 
          bookingCloseHour: 21, 
          bookingCloseMinute: 00, 
          harga: 0, 
          gallery: []
        )
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Pesan Lapangan disini',
            style: TextStyle(
              fontWeight: medium,
              fontSize: 20
            ),
          ),
        ),
        const SizedBox(height: 12,),

        GridView.count(
          crossAxisCount: 1,  //Jumlah kolom
          mainAxisSpacing: 16, //Jarak item atas dan bawah
          crossAxisSpacing: 12,  //Jarak item kiri dan kanan
          childAspectRatio: 395/196,  //Aspek rasio item(Selalu mengambil width dan height semaksimal mungkin dengan mempertahankan aspek rasio)
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),  //Tidak ada fungsi scroll
          children: tempListField.map((e) {   //change List<FieldModel> to List<FieldGridItem>
            return FieldGridItem(
              id: e.id,
              name: e.name, 
              timeHourStart: e.bookingOpenHour,
              timeMinuteStart: e.bookingOpenMinute, 
              timeHourEnd: e.bookingCloseHour, 
              timeMinuteEnd: e.bookingCloseMinute
            );
          }).toList(),
        )
      ],
    );
  }
}