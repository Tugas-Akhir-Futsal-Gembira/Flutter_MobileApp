import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/screen/login_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/lupa_password/atur_ulang_password_screen.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';

class LupaPasswordInputOTPScreen extends StatelessWidget {
  const LupaPasswordInputOTPScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {

    TextEditingController emailTextController = TextEditingController(text: email);
    TextEditingController otpTextController = TextEditingController();
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
                                        'Lupa Password',
                                        style: TextStyle(fontWeight: semiBold, fontSize: 32),
                                      ),
                                      const SizedBox(height: 60,),
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: regular,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Masukkan kode OTP atur ulang password',
                                              style: TextStyle(fontWeight: semiBold),
                                            ),
                                            TextSpan(
                                              text: ' yang diterima dari email untuk mengatur ulang password anda.'
                                            ),
                                          ]
                                        )
                                      ),
                                      const SizedBox(height: 40,),
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
                                        title: 'Kode OTP',
                                        value: null,
                                        controller: otpTextController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if(otpTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 40,),
                                      const Text(
                                        'Setelah menekan tombol kirimkan, maka anda dapat mengubah password anda dan kode otp yang diterima pada email anda tidak dapat digunakan kembali',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: regular,
                                          color: warningColor,
                                        ),
                                      ),
                            
                                    ],
                                  ),
                            
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 64),

                                        ///Button 'Kirimkan'
                                        child: CustomButton(
                                          value: 'Kirimkan', 
                                          size: const Size(202, 44),
                                          fontSize: 20,
                                          onPressed: (){
                                            if(formKey.currentState!.validate()){
                                              Navigator.pushReplacement(
                                                context, 
                                                MaterialPageRoute(
                                                  builder: (context) => AturUlangPasswordScreen(
                                                    email: emailTextController.text
                                                  ),
                                                )
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Kembali ke halaman ',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: regular,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: 'Masuk',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = (){ 
                                                  Navigator.pushReplacement(
                                                    context, 
                                                    MaterialPageRoute(builder: (context) => const LoginScreen(),)
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