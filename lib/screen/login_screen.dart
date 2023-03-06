import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/daftar_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/lupa_password_screen.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailTextController = TextEditingController();
    TextEditingController passwordTextController = TextEditingController();
    
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Futsal\nGembira',
                                      style: TextStyle(fontWeight: semiBold, fontSize: 32),
                                    ),
                                    const SizedBox(height: 20,),
                                    CustomTextfield(
                                      title: 'Email',
                                      value: null,
                                      controller: emailTextController,
                                    ),
                                    const SizedBox(height: 20,),
                                    CustomTextfield(
                                      title: 'Password',
                                      type: CustomTextfieldType.password,
                                      controller: passwordTextController,
                                    ),
                                    const SizedBox(height: 8,),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Lupa Password?',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = (){
                                              Navigator.pushReplacement(
                                                context, 
                                                MaterialPageRoute(builder: (context) => const LupaPasswordScreen(),)
                                              );
                                            },
                                          style: TextStyle(
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
                                        onPressed: (){},
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Belum punya akun? ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: regular,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Buat Akun',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){ 
                                                Navigator.pushReplacement(
                                                  context, 
                                                  MaterialPageRoute(builder: (context) => const DaftarScreen(),)
                                                );
                                              },
                                            style: TextStyle(
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