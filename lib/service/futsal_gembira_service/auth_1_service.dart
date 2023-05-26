import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';

class Auth1Service{

  final Dio _dio = Dio();
  final String _baseUrl = CustomUrl.futsalGembiraUrl;

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
        return JSONModel(message: 'Error');
      }
    }
  }

  

}