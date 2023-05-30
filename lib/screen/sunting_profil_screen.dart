import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_dropdown_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class SuntingProfilScreen extends StatelessWidget {
  const SuntingProfilScreen({
    super.key,
    this.pictureLink,
    this.profileName = 'Tidak ada data',
    this.sex,
    this.uniqueId = 'Tidak ada ID',
    this.phoneNumber = 'Tidak ada data',
    this.email = 'Tidak ada data',
    this.address = 'Tidak ada data',
  });

  final String? pictureLink;
  final String profileName;
  ///1. Male, 2. Female, null. Not Specified.
  final int? sex;
  final String uniqueId;
  final String phoneNumber;
  final String email;
  final String address;

  @override
  Widget build(BuildContext context) {

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    ValueNotifier<File?> circleImageValueNotifier = ValueNotifier(null);
    TextEditingController nameTextEditingController = TextEditingController(text: profileName);
    TextEditingController phoneTextEditingController = TextEditingController(text: phoneNumber);
    TextEditingController addressTextEditingController = TextEditingController(text: address);
    CustomDropdownButtonController sexCustomDropdownButtonController = CustomDropdownButtonController(
      itemString: ['Pria', 'Wanita'], 
      ///If sex == 2(Wanita) -> 1
      ///Else (even 1(Pria) or null) -> 0 
      indexItemString: (sex == 2) ? 1 : 0
    );
    CustomButtonController customButtonController = CustomButtonController(isLoading: false);

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
            'Sunting Profil',
            style: TextStyle(
              fontWeight: semiBold,
              fontSize: 20,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
          
                ///ImageCircle
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 24,),
                    
                    ///Circle
                    ValueListenableBuilder(
                      valueListenable: circleImageValueNotifier,
                      builder: (context, value, child) {
                        return Container(
                          width: 131,
                          height: 131,
                          decoration: BoxDecoration(
                            color: primaryBaseColor,
                            border: Border.all(color: primaryLightestColor),
                            shape: BoxShape.circle,
                            image: (circleImageValueNotifier.value != null)
                                ? DecorationImage(
                                  image: FileImage(circleImageValueNotifier.value!),
                                  fit: BoxFit.cover
                                )
                                : null
                          ),
                          child: (pictureLink != null || circleImageValueNotifier.value != null)
                              ? null
                              : SvgPicture.asset(
                                'assets/icon/User.svg',
                                width: 85,
                                height: 85,
                                fit: BoxFit.none,
                              ),
                        );
                      }
                    ),

                    ///IconButton (Edit Icon, for taking photo from file explorer)
                    GestureDetector(
                      onTap: () async {

                        bool storagePermissionIsGranted = await Permission.storage.request().isGranted;

                        if(storagePermissionIsGranted){
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.image
                          );

                          if(result != null) {
                            circleImageValueNotifier.value = File(result.files.single.path!);
                          }
                        }
                        else if(context.mounted){
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar(
                              duration: const Duration(seconds: 10),
                              title: 'Aplikasi ini masih belum mendapatkan ijin akses penyimpanan yang digunakan untuk mengakses foto.\n\nMohon berikan ijin akses penyimpanan agar dapat melanjutkan aksi.'
                            )
                          );
                        }

                      },
                      child: SvgPicture.asset(
                        'assets/icon/Pencil.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),     ///End of ImageCircle
                const SizedBox(height: 32,),
          


                ///Bunch of textField
                CustomTextfield(
                  title: 'Nama',
                  type: CustomTextfieldType.edit,
                  controller: nameTextEditingController,
                  validator: (value) {
                    
                  },
                ),
                const SizedBox(height: 32,),
          
                CustomTextfield(
                  title: 'ID Unik Pengguna',
                  type: CustomTextfieldType.disabled,
                  value: uniqueId,
                ),
                const SizedBox(height: 32,),
          
                Builder(
                  builder: (context) {
                    String stringSex;
                    switch(sex){
                      case 1: {
                        stringSex = 'Pria';
                        break;
                      }
                      case 2: {
                        stringSex = 'Wanita';
                        break;
                      }
                      default: {
                        stringSex = 'Tidak ditentukan';
                      }
                    }

                    return CustomDropdownButton(
                      context: context,
                      controller: sexCustomDropdownButtonController,
                      title: 'Jenis Kelamin',
                      value: 'Pria',
                      itemString: const ['Pria', 'Wanita'],
                      isExpanded: true,
                      onChanged: (value) {
                        sexCustomDropdownButtonController.findIndexItemString(value);
                      },
                      onTap: () {
                        
                      },
                    );
                  }
                ),
                const SizedBox(height: 32,),

          
                CustomTextfield(
                  title: 'No. Telepon',
                  type: CustomTextfieldType.edit,
                  controller: phoneTextEditingController,
                  validator: (value) {
                    
                  },
                ),
                const SizedBox(height: 32,),
          
                CustomTextfield(
                  title: 'Email',
                  type: CustomTextfieldType.disabled,
                  value: email,
                ),
                const SizedBox(height: 32,),
          
                CustomTextfield(
                  title: 'Alamat',
                  type: CustomTextfieldType.edit,
                  controller: addressTextEditingController,
                  validator: (value) {
                    
                  },
                ),
                const SizedBox(height: 48,),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    value: 'Simpan Perubahan', 
                    controller: customButtonController,
                    size: const Size(double.infinity, 48),
                    fontSize: 16,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}