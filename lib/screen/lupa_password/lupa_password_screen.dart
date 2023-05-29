import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/screen/login_screen.dart';
import 'package:flutter_application_futsal_gembira/screen/lupa_password/atur_ulang_password_screen.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';

class LupaPasswordScreen extends StatelessWidget {
  const LupaPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    ValueNotifier<bool> isLoadingButton = ValueNotifier(false);
    TextEditingController emailTextController = TextEditingController();
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
                                              text: 'Masukkan email ',
                                              style: TextStyle(fontWeight: semiBold),
                                            ),
                                            TextSpan(
                                              text: 'anda. Kami akan mengirimkan sebuah '
                                            ),
                                            TextSpan(
                                              text: 'kode OTP atur ulang password lewat email',
                                              style: TextStyle(fontWeight: semiBold),
                                            ),
                                            TextSpan(
                                              text: ' untuk mengatur ulang password anda.'
                                            )
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
                                      const SizedBox(height: 8,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Sudah menerima kode?',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.pushReplacement(
                                                  context, 
                                                  MaterialPageRoute(
                                                    builder: (context) => const AturUlangPasswordScreen(email: null),
                                                  )
                                                );
                                              },
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: semiBold,
                                              decoration: TextDecoration.underline,
                                            )
                                          )
                                        )
                                      ),
                                      const SizedBox(height: 20,),
                                      const Text(
                                        'Jika anda mempunyai kode OTP atur ulang password yang lama, tautan tersebut tidak dapat digunakan kembali jika anda telah klik tombol Kirimkan',
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
                                        child: ValueListenableBuilder(
                                          valueListenable: isLoadingButton,
                                          builder: (context, value, child) {
                                            return CustomButton(
                                              value: 'Kirimkan', 
                                              size: const Size(202, 44),
                                              fontSize: 20,
                                              isLoading: (isLoadingButton.value == true) ? true : false,
                                              onPressed: () async{
                                                isLoadingButton.value = true;
                                                FocusManager.instance.primaryFocus?.unfocus();

                                                ///If validation of form return true
                                                if(formKey.currentState!.validate()){

                                                  JSONModel json = await GateService.postResetPassword(
                                                    email: emailTextController.text
                                                  );

                                                  if(json.statusCode == 200 && context.mounted){
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => AturUlangPasswordScreen(email: emailTextController.text),
                                                      )
                                                    );
                                                  }
                                                  else if(context.mounted){
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      CustomSnackbar(title: json.getErrorToString())
                                                    );
                                                  }
                                                }
                                                isLoadingButton.value = false;
                                              },
                                            );
                                          }
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