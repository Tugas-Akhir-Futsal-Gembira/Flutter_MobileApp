import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/aturan_penyewaan/widget/aturan_penyewaan_item.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AturanPenyewaanScreen extends StatelessWidget {
  const AturanPenyewaanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/football doodle.jpg'),
          colorFilter: ColorFilter.mode(Color(0xFA2F2F2F), BlendMode.srcATop),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        ///AppBar
        appBar: AppBar(
          toolbarHeight: 71,
          backgroundColor: primaryBaseColor,
          elevation: 0,
          titleSpacing: 20,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/icon/Caret-Left.svg'),
          ),
          title: const Text(
            'Aturan Penyewaan',
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 20,
            ),
          ),
        ),

        ///Body
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: const [
              Text(
                'Kumpulan aturan yang diterapkan pada aplikasi futsal gembira',
                style: TextStyle(fontWeight: regular, fontSize: 16),
              ),
              SizedBox(height: 32,),

              ///'Durasi minimal penyewaan'
              AturanPenyewaanItem(
                title: 'Durasi minimal penyewaan',
                value: '1',
                value2: 'Jam', 
                description: 'Adalah durasi waktu yang dibutuhkan sebagai batasan paling rendah dalam memberi durasi penyewaan sebuah lapangan.',
                colorDebug: false,
              ),
              SizedBox(height: 8,),

              ///'Durasi maximal penyewaan'
              AturanPenyewaanItem(
                title: 'Durasi maximal penyewaan',
                value: '2',
                value2: 'Jam', 
                description: 'Adalah durasi waktu yang dibutuhkan sebagai batasan paling tinggi dalam memberi durasi penyewaan sebuah lapangan.',
                colorDebug: false,
              ),
              SizedBox(height: 8,),

              ///'Selisih waktu minimal antara waktu pemesanan...'
              AturanPenyewaanItem(
                title: 'Selisih waktu minimal antara waktu pemesanan sewa dan waktu penggunaan lapangan',
                value: '120',
                value2: 'Menit', 
                description: 'Adalah perbedaan waktu paling rendah antara waktu ketika pengguna memesan penyewaan dan waktu lapangan yang disewa.',
                colorDebug: false,
              ),
              SizedBox(height: 8,),

              ///'Selisih hari maksimal antara hari pemesanan...'
              AturanPenyewaanItem(
                title: 'Selisih hari maksimal antara hari pemesanan sewa dan hari penggunaan lapangan',
                value: '7',
                value2: 'Hari', 
                description: 'Adalah perbedaan hari paling tinggi antara hari ketika pengguna memesan penyewaan dan hari lapangan yang disewa.',
                colorDebug: false,
              ),
              SizedBox(height: 8,),

              ///'Durasi masa pembayaran penyewaan lapangan'
              AturanPenyewaanItem(
                title: 'Durasi masa pembayaran penyewaan lapangan',
                value: '15',
                value2: 'Menit', 
                description: 'Adalah durasi waktu yang diberikan kepada pengguna setelah lapangan yang dipilih oleh pengguna telah disetujui oleh sistem.',
                colorDebug: false,
              ),
              SizedBox(height: 8,),


              ///'Ijinkan pengguna untuk menyewa lapangan lain...'
              AturanPenyewaanItem(
                title: 'Ijinkan pengguna untuk menyewa lapangan lain ketika ada penyewaan yang statusnya masih menunggu pembayaran',
                value: null,
                value2: 'Tidak', 
                description: 'Adalah sebuah ijin yang diberikan kepada pengguna jika terdapat penyewaan lapagan lain yang statusnya masih menunggu pembayaran.',
                colorDebug: false,
              ),
              SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }
}