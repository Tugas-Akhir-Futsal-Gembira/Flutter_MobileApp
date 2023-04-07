import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/keluar_dialog.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/pengaturan_listitem.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/profile_container.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            ///First Row: Profile
            ProfileContainer(
              pictureLink: null,
              profileName: 'Chandra',
              sex: 1,
              uniqueId: 'user@04012023-30',
              phoneNumber: '081234567890',
              email: 'example123@mail.com',
              address: 'Tidak ada data',
              accountCreated: DateTime(2023,1,4),
              temporaryBlockedSecondRemaining: 900,
            ),
            const SizedBox(height: 32,),

            PengaturanListItem(
              title: 'Tentang',
              assetName: 'assets/icon/Info-Circle.svg',
              onTap: (){},
            ),
            const SizedBox(height: 8,),

            PengaturanListItem(
              title: 'Dukungan',
              assetName: 'assets/icon/Question-Circle.svg',
              onTap: (){},
            ),
            const SizedBox(height: 8,),

            PengaturanListItem(
              title: 'Keluar',
              assetName: 'assets/icon/Logout.svg',
              onTap: (){
                keluarDialog(context);
              }
            ),
            const SizedBox(height: 8,),
          ],
        )
      ),
    );
  }
}