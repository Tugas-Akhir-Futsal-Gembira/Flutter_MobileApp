import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/keluar_dialog.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/pengaturan_listitem.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/profile_container.dart';
import 'package:flutter_application_futsal_gembira/variables/variables.dart';

class PengaturanScreen extends StatelessWidget {
  const PengaturanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async{

        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
      
              ///First Row: Profile
              // const ProfileContainer(
              //   pictureLink: null,
              //   profileName: 'Chandra',
              //   sex: 1,
              //   uniqueId: 'user@04012023-30',
              //   phoneNumber: '081234567890',
              //   email: 'example123@mail.com',
              //   address: 'Tidak ada data',
              // ),
              ProfileContainer.fromProfileModel(Variables.profileData!),
              const SizedBox(height: 32,),
      
              ///Second Row: Tentang
              PengaturanListItem(
                title: 'Tentang',
                assetName: 'assets/icon/Info-Circle.svg',
                onTap: (){},
              ),
              const SizedBox(height: 8,),
      
              ///Third Row: Dukungan
              PengaturanListItem(
                title: 'Dukungan',
                assetName: 'assets/icon/Question-Circle.svg',
                onTap: (){},
              ),
              const SizedBox(height: 8,),
              
              ///Forth Row: Keluar
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
      ),
    );
  }
}