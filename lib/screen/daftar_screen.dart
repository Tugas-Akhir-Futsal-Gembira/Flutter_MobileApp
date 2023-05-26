import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/screen/login_screen.dart';
import 'package:flutter_application_futsal_gembira/service/gate_service.dart';
import 'package:flutter_application_futsal_gembira/style/font_weight.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_button.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_snackbar.dart';
import 'package:flutter_application_futsal_gembira/widget/custom_textfield.dart';

class DaftarScreen extends StatelessWidget {
  const DaftarScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController nameTextController = TextEditingController();
    TextEditingController emailTextController = TextEditingController();
    TextEditingController nohpTextController = TextEditingController();
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
                            ///Form
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Daftar',
                                        style: TextStyle(fontWeight: semiBold, fontSize: 32),
                                      ),
                                      const SizedBox(height: 20,),
                                      CustomTextfield(
                                        title: 'Nama',
                                        controller: nameTextController,
                                        validator: (value) {
                                          if(nameTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 20,),
                                      CustomTextfield(
                                        title: 'Email',
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
                                        title: 'No HP',
                                        controller: nohpTextController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if(nohpTextController.text.length < 8){
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
                                      const SizedBox(height: 20,),
                                      CustomTextfield(
                                        title: 'Konfirmasi Password',
                                        type: CustomTextfieldType.password,
                                        controller: konfirmasiPasswordTextController,
                                        validator: (value) {
                                          if(konfirmasiPasswordTextController.text.length < 8){
                                            return 'Input tidak boleh kosong atau tidak boleh berisi kurang dari 8 karakter';
                                          }
                                          return (passwordTextController.text != konfirmasiPasswordTextController.text) 
                                              ? 'Input pada Konfirmasi Password harus sama dengan Password' : null;
                                        },
                                      ),
                                    ],
                                  ),
                                            
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 64),
                                        child: CustomButton(
                                          value: 'Daftar', 
                                          size: const Size(202, 44),
                                          onPressed: () async{

                                            ///If validation of form return true
                                            if(formKey.currentState!.validate()){

                                              JSONModel json = await GateService.postRegister(
                                                username: nameTextController.text, 
                                                email: emailTextController.text, 
                                                password: passwordTextController.text, 
                                                phone: nohpTextController.text,
                                              );

                                              if(json.statusCode == 201 && context.mounted){
                                                Navigator.pushReplacement(
                                                  context, 
                                                  MaterialPageRoute(builder: (context) => const LoginScreen(),)
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  CustomSnackbar(
                                                    title: 'Buka email anda untuk validasi akun',
                                                  )
                                                );
                                              }

                                              else if(context.mounted){
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  CustomSnackbar(
                                                    title: json.statusCode.toString() + json.message,
                                                  )
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Sudah punya akun? ',
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