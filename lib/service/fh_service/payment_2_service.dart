import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';

class Payment2Service{
  
  final Dio _dio = Dio();
  final String _baseUrl = CustomUrl.fhUrl;

  ///List Payment
  Future<JSONModel> getListPayment() async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    try{
      response = await _dio.get(
        '$_baseUrl/payments',
        options: Options(
          headers: {
            'token': accessToken
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

  ///Tutorial Payment
  Future<JSONModel> getTutorialPayment({
    required int paymentMethodId,
    required String kodePembayaran,
  }) async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    try{
      response = await _dio.get(
        '$_baseUrl/payments/tutorial/$paymentMethodId?virtual_account=$kodePembayaran',
        options: Options(
          headers: {
            'token': accessToken
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