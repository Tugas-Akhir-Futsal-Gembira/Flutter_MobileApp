import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';

class Auth2Service{

  final Dio _dio = Dio();
  final String _baseUrl = CustomUrl.fhUrl;

  ///Register
  Future<JSONModel> postRegister({
    required String name,
    required String email,
    required String noHp,
    required String password,
    required String confirmPassword,
    required String fcmToken,
  }) async{

    Response response;

    try{
      response = await _dio.post(
        '$_baseUrl/auth/register',
        data: {
          'name': name,
          'email': email,
          'no_hp': noHp,
          'password': password,
          'confirm_password': confirmPassword,
          'fcm_token': fcmToken,
        }
      );

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: 'Error');
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }

  ///Login
  Future<JSONModel> postLogin({
    required String email,
    required String password,
    required String fcmToken,
  }) async{

    Response response;

    try{
      response = await _dio.post(
        '$_baseUrl/auth/login',
        data: {
          'email': email,
          'password': password,
          'fcm_token': fcmToken,
        }
      );
      
      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: 'Error');
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }

  /// Otp (Send OTP for Reset Password)
  Future<JSONModel> postOTP({
    required String email,
  }) async{

    Response response;

    try{
      response = await _dio.post(
        '$_baseUrl/auth/otp-forgot-password',
        data: {
          'email': email,
        }
      );

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: 'Error');
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }

  ///Forgot Password(Update Password by using OTP gained from email)
  Future<JSONModel> putForgotPassword({
    required String email,
    required String code,
    required String password,
    required String confirmPassword,
  }) async{

    Response response;

    try{
      response = await _dio.put(
        '$_baseUrl/auth/forgot-password',
        data: {
          'email': email,
          'code': code,
          'password': password,
          'confirm_password': confirmPassword
        }
      );

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: 'Error');
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }

  ///Profile (Me)
  Future<JSONModel> getProfile() async{
    
    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    try{
      response = await _dio.get(
        '$_baseUrl/user/profile',
        options: Options(
          headers: {
            'token': accessToken,
          }
        )
      );

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: 'Error');
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }
  
}