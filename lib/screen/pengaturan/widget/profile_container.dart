import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/profile/profile_model.dart';
import 'package:flutter_application_futsal_gembira/screen/sunting_profil_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
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

  factory ProfileContainer.fromProfileModel(ProfileModel model){

    int? sexTemp;
    switch(model.gender){
      case 'male': {
        sexTemp = 1;
        break;
      }
      case 'female': {
        sexTemp = 2;
        break;
      }
      default: {
        sexTemp = null;
      }
    }

    return ProfileContainer(
      pictureLink: model.thumbnail,
      profileName: model.name,
      sex: sexTemp,
      uniqueId: model.idUnik.toString(),
      phoneNumber: model.phone,
      email: model.email,
      address: model.address.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(

      ///First Stack: Container with visuals
      children: [
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 22, bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: primaryLightestColor,
            ),
            color: primaryLightColor,
          ),
          child: LayoutBuilder(
            builder: (p0context, p1constraint){
              
              ///ratio for deciding profilePicture radius
              double ratio = (131 / p1constraint.maxWidth) * 100;
              late double profilePictureRadius;

              ///If ratio is less than 34.737% then width = 131
              ///Else width = ratio * p1constraint.maxWidth * 100
              profilePictureRadius = (ratio < 34.737) ? 131 : (ratio * p1constraint.maxWidth) / 100;

              return Column(
                children: [

                  ///First Row: Picture and user personal data
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ///ProfilePicture
                      Container(
                        height: profilePictureRadius,
                        width: profilePictureRadius,
                        decoration: BoxDecoration(
                          color: primaryBaseColor,
                          shape: BoxShape.circle,
                          image: (pictureLink == null)
                              ? null
                              : DecorationImage(image: NetworkImage(pictureLink!))
                        ),
                        child: (pictureLink == null) 
                            ? FittedBox(
                              fit: BoxFit.none,
                              child: SvgPicture.asset(
                                'assets/icon/User.svg', 
                                height: 85/131 * profilePictureRadius, 
                                width: 85/131 * profilePictureRadius,
                              ),
                            )
                            : null,
                      ),
                      const SizedBox(width: 20,),

                      ///User personal data
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ///First Row personal data: profileName, sex
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    profileName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: semiBold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Builder(builder: (context) {
                                  String assetName = 'assets/icon/';
                                  if(sex == null){
                                    return const SizedBox();
                                  }
                                  if(sex == 1){
                                    assetName += 'material-symbols_male.svg';
                                  }
                                  else{
                                    assetName += 'material-symbols_female.svg';
                                  }
                                  return SvgPicture.asset(assetName);
                                },)
                              ],
                            ),

                            ///Second Row personal data: uniqueId
                            Text(
                              uniqueId,
                              style: const TextStyle(
                                color: primaryLightestColor,
                                fontWeight: regular,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20,),

                            ///Third Row personal data: phoneNumber
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icon/Phone.svg',
                                  height: 14,
                                  width: 14,
                                ),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Text(
                                    phoneNumber,
                                    style: const TextStyle(
                                      fontWeight: regular,
                                      fontSize: 12
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 4,),

                            ///Forth Row personal data: email
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icon/Envelope.svg',
                                  height: 14,
                                  width: 14,
                                ),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Text(
                                    email,
                                    style: const TextStyle(
                                      fontWeight: regular,
                                      fontSize: 12
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 4,),

                            ///Fifth Row personal data: address
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icon/mdi_address-marker.svg',
                                  height: 14,
                                  width: 14,
                                ),
                                const SizedBox(width: 8,),
                                Expanded(
                                  child: Text(
                                    address,
                                    style: const TextStyle(
                                      fontWeight: regular,
                                      fontSize: 12
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 4,),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16,),

                  ///Second Row: 'Sunting Profil' text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      ///First Column: Spacer to fill remaining space
                      const Spacer(),

                      ///Second & Third Column: 'Sunting Profil' text and icon
                      const Text(
                        'Sunting Profil',
                        style: TextStyle(
                          fontWeight: medium,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4,),

                      SvgPicture.asset(
                        'assets/icon/Caret-Right.svg',
                        width: 24,
                        height: 24,
                      ),
                    ],
                  )
                ],
              );
            }
          ),
        ),

        ///Second Stack: Material and InkWell
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SuntingProfilScreen(
                      pictureLink: null,
                      profileName: 'Chandra',
                      sex: 1,
                      uniqueId: 'user@04012023-30',
                      phoneNumber: '081234567890',
                      email: 'example123@mail.com',
                      address: 'Tidak ada data',
                    ),
                  )
                );
              },
              borderRadius: BorderRadius.circular(5),
              highlightColor: primaryBaseColor.withOpacity(0.5),
              splashColor: primaryLightestColor.withOpacity(0.5),
            ),
          )
        ),
      ],
    );
  }
}