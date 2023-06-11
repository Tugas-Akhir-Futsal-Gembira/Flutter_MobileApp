import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/model/profile/profile_model.dart';
import 'package:flutter_application_futsal_gembira/screen/daftar_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/lupa_password/lupa_password_screen.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';
import 'package:flutter_application_futsal_gembira/variables/variables.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';
import 'package:flutter_application_futsal_gembira/screen/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    CustomButtonController customButtonController = CustomButtonController(isLoading: false);
    TextEditingController emailTextController = TextEditingController();
    TextEditingController passwordTextController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Lapangan futsal wallpaper.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Color(0x3E2F2F2F), BlendMode.srcATop)
          )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (p0context, p1constraint) => Stack(
              children: [
        
                ///The background image with gradient color
                Column(
                  children: [
                    Container(
                      height: (p1constraint.maxHeight * 25 / 100).ceilToDouble(),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x002F2F2F),
                            Color(0xE42F2F2F),
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: const Color(0xE42F2F2F)
                      ),
                    ),
                  ],
                ),

                ///All texts
                SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: p1constraint.maxHeight
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.amber.withOpacity(0.0),
                          constraints: BoxConstraints(
                            minHeight: p1constraint.maxHeight * 15 / 100
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: p1constraint.maxHeight * 75 / 100
                          ),
                          color: Colors.red.withOpacity(0.0),
                          padding: const EdgeInsets.only(
                            bottom: 64,
                            left: 20,
                            right: 20,
                          ),
                          child: Container(
                            color: Colors.blue.withOpacity(0.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Futsal\nGembira',
                                        style: TextStyle(fontWeight: semiBold, fontSize: 32),
                                      ),
                                      const SizedBox(height: 20,),
                                      CustomTextfield(
                                        title: 'Email',
                                        value: null,
                                        controller: emailTextController,
                                        validator: (value) {
                                          if(emailTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20,),
                                      CustomTextfield(
                                        title: 'Password',
                                        type: CustomTextfieldType.password,
                                        controller: passwordTextController,
                                        validator: (value) {
                                          if(passwordTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 8,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Lupa Password?',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(
                                                  context, 
                                                  MaterialPageRoute(builder: (context) => const LupaPasswordScreen(),)
                                                );
                                              },
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: semiBold,
                                              decoration: TextDecoration.underline,
                                            )
                                          )
                                        )
                                      )
                                    ],
                                  ),
                            
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 64),
                                        child: CustomButton(
                                          value: 'Masuk', 
                                          size: const Size(202, 44),
                                          fontSize: 20,
                                          controller: customButtonController,
                                          onPressed: () async{
                                            customButtonController.isLoading = true;
                                            FocusManager.instance.primaryFocus?.unfocus();

                                            ///Get FCM TOKEN
                                            String? fcmToken = await FirebaseMessaging.instance.getToken();
                                            
                                            ///If validation of form return true
                                            if(formKey.currentState!.validate() && fcmToken!= null){

                                              JSONModel json = await GateService.postLogin(
                                                email: emailTextController.text, 
                                                password: passwordTextController.text, 
                                                fcmToken: fcmToken
                                              );
                                              
                                              if(json.statusCode == 200){

                                                String accessToken = json.data!['access_token'] as String;
                                                await accessToken.setPref(MySharedPreferences.accessTokenKey);

                                                JSONModel jsonProfile = await GateService.getMe();
                                                if(jsonProfile.statusCode == 200 && jsonProfile.data != null){
                                                  Variables.profileData = ProfileModel.fromJSON(jsonProfile.data!);
                                                }
                                              }

                                              ///If profileData is not null, navigate to MainScreen
                                              ///Else will not go anywhere
                                              if(Variables.profileData != null){

                                                if(context.mounted){
                                                  Navigator.pushReplacement(
                                                    context, 
                                                    MaterialPageRoute(builder: (context) => const MainScreen(),)
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    CustomSnackbar(title: 'Berhasil Login',)
                                                  );
                                                }
                                              }

                                              else if(context.mounted){
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  CustomSnackbar(
                                                    title: json.getErrorToString(),
                                                    color: error2Color,
                                                  )
                                                );
                                              }
                                            }
                                            customButtonController.isLoading = false;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Belum punya akun? ',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: regular,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Buat Akun',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = (){ 
                                                  Navigator.push(
                                                    context, 
                                                    MaterialPageRoute(builder: (context) => const DaftarScreen(),)
                                                  );
                                                },
                                              style: const TextStyle(
                                                decoration: TextDecoration.underline,
                                                fontWeight: semiBold,
                                              )
                                            )
                                          ]
                                        )
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
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