import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';

class Auth1Service{

  final Dio _dio = Dio();
  final String _baseUrl = CustomUrl.futsalGembiraUrl;

  ///Register
  Future<JSONModel> postRegister({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async{

    Response response;

    try{
      response = await _dio.post(
        '$_baseUrl/auth/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
          'phone': phone
        },
      );

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: e.toString());
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
        return JSONModel(message: e.toString());
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }

  }

  ///Reset Password
  Future<JSONModel> postResetPassword({
    required String email
  }) async{

    Response response;

    try{
      response = await _dio.post(
        '$_baseUrl/auth/reset-password',
        data: {
          'email': email
        }
      );

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: e.toString());
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }

  ///Update Password
  Future<JSONModel> patchUpdatePassword({
    required String email,
    required String code,
    required String password,
  }) async{

    Response response;

    try{
      response = await _dio.patch(
        '$_baseUrl/auth/update-password',
        data: {
          'email': email,
          'code': code,
          'password': password,
        }
      );

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        return JSONModel.fromJSON(e.response!.data, e.response!.statusCode!);
      }
      else{
        return JSONModel(message: e.toString());
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }

  ///ME
  Future<JSONModel> getMe() async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    try{
      response = await _dio.get(
        '$_baseUrl/auth/me',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken'
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
        return JSONModel(message: e.toString());
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
  }
}