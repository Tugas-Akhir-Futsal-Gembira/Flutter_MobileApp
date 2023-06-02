import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/profile/profile_model.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/keluar_dialog.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/pengaturan_listitem.dart';
import 'package:flutter_application_futsal_gembira/screen/pengaturan/widget/profile_container.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/variables/variables.dart';

class PengaturanScreen extends StatefulWidget {
  const PengaturanScreen({super.key});

  @override
  State<PengaturanScreen> createState() => _PengaturanScreenState();
}

class _PengaturanScreenState extends State<PengaturanScreen> {

  ValueNotifier<bool> isLoadingValueNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: RefreshIndicator(
        onRefresh: () async{
          await refresh();
        },
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                ValueListenableBuilder(
                  valueListenable: isLoadingValueNotifier,
                  builder: (context, value, child) {
                    return ProfileContainer.fromProfileModel(
                      Variables.profileData!, 
                      isLoading: isLoadingValueNotifier.value,
                      isChanged: (value) {
                        refresh();
                      },
                    );
                  }
                ),
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
      ),
    );
  }

  Future<void> refresh() async{
    
    isLoadingValueNotifier.value = true;

    JSONModel json = await GateService.getMe();
    if(json.statusCode == 200){
      print(json.toString1());
      Variables.profileData = ProfileModel.fromJSON(json.data!);
    }

    isLoadingValueNotifier.value = false;
  }
}