import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/beranda/widget/field_listitem.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';

class FieldListView extends StatelessWidget {
  const FieldListView({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
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
          children: const [
            FieldGridItem(
              name: 'Lapangan #1', 
              timeHourStart: 10,
              timeMinuteStart: 00,
              timeHourEnd: 21,
              timeMinuteEnd: 00,
            ),
            
            FieldGridItem(
              name: 'Lapangan #2', 
              timeHourStart: 10,
              timeMinuteStart: 00,
              timeHourEnd: 21,
              timeMinuteEnd: 00,
            ),

          ],
        )
      ],
    );
  }
}