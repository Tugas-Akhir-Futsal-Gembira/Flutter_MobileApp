import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/screen/login_screen.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/color_style.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_alert_dialog.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';

class AturUlangPasswordScreen extends StatelessWidget {
  const AturUlangPasswordScreen({super.key, required this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {

    TextEditingController emailTextController = TextEditingController(text: email);
    TextEditingController kodeOTPTextController = TextEditingController();
    TextEditingController passwordTextController = TextEditingController();
    TextEditingController konfirmasiPasswordTextController = TextEditingController();
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

                                  ///Texts and TextFields
                                  Column(
                                    children: [
                                      const Text(
                                        'Atur Ulang Password',
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
                                              text: 'Masukkan password yang baru',
                                              style: TextStyle(fontWeight: semiBold),
                                            ),
                                            TextSpan(
                                              text: ' pada akun anda.',
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
                                          if(passwordTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextfield(
                                        title: 'Kode OTP',
                                        value: null,
                                        controller: kodeOTPTextController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if(passwordTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      CustomTextfield(
                                        title: 'Password',
                                        value: null,
                                        controller: passwordTextController,
                                        type: CustomTextfieldType.password,
                                        validator: (value) {
                                          if(passwordTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20,),
                                      CustomTextfield(
                                        title: 'Konfirmasi Password',
                                        value: null,
                                        controller: konfirmasiPasswordTextController,
                                        type: CustomTextfieldType.password,
                                        validator: (value) {
                                          if(konfirmasiPasswordTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return (passwordTextController.text != konfirmasiPasswordTextController.text) 
                                                ? 'Input pada Konfirmasi Password harus sama dengan Password' : null;
                                        },
                                      ),
                                      const SizedBox(height: 40,),
                                      const Text(
                                        'Setelah menekan tombol Atur Ulang, maka password lama pada akun anda tidak dapat digunakan dan password baru akan langsung dapat digunakan',
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
                                        child: CustomButton(
                                          value: 'Atur Ulang', 
                                          size: const Size(202, 44),
                                          fontSize: 20,
                                          onPressed: () async{
                                            FocusScope.of(context).requestFocus(FocusNode());
                                            if(formKey.currentState!.validate()){

                                              JSONModel json = await GateService.patchUpdatePassword(
                                                email: emailTextController.text,
                                                password: passwordTextController.text,
                                                code: kodeOTPTextController.text
                                              );

                                              if(json.statusCode == 200 && context.mounted){
                                                showDialog(
                                                  context: context, 
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return CustomAlertDialog(
                                                      context: context,
                                                      backgroundColor: primaryLightColor,
                                                      visibleFirstButton: true,
                                                      visibleSecondButton: false,
                                                      backgroundColorFirstButton: success2Color,
                                                      childFirstButton: const Text(
                                                        'OK',
                                                        style: TextStyle(
                                                          fontWeight: semiBold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      onPressedFirstButton: () {
                                                        Navigator.pop(context);
                                                        Navigator.pushReplacement(
                                                          context, 
                                                          MaterialPageRoute(
                                                            builder: (context) => const LoginScreen(),
                                                          )
                                                        );
                                                      },
                                                      content: WillPopScope(
                                                        onWillPop: () async{
                                                          return false;
                                                        },
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: const [
                                                            SizedBox(height: 16,),
                                                            Text(
                                                              'Berhasil Atur Ulang',
                                                              style: TextStyle(
                                                                fontWeight: semiBold,
                                                                fontSize: 24
                                                              ),
                                                            ),
                                                            SizedBox(height: 32),
                                                            Text(
                                                              'Atur Ulang Password berhasil.\n Akun anda telah menyimpan password yang baru',
                                                              textAlign: TextAlign.center,
                                                              style: TextStyle(
                                                                fontWeight: regular,
                                                                fontSize: 16
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ),
                                                    );
                                                  },
                                                );
                                              }
                                              else if (context.mounted){
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  CustomSnackbar(title: json.statusCode.toString() + json.message.toString())
                                                );
                                              }
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