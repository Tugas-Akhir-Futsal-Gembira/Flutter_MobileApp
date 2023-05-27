import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';

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

}