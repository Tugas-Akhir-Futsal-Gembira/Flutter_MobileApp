import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class User2Service{

  final Dio _dio = Dio();
  final String _baseUrl = CustomUrl.fhUrl;

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

  ///Update Profile
  Future<JSONModel> putUpdateProfile({
    required String name,
    required String noHp,
    required String address,
    required int gender,
    File? thumbnail,
  }) async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    ///1 = LK, 2 = PR
    String genderString = (gender == 1) ? 'LK' : 'PR';
    Map<String, dynamic> data = {
      'name': name,
      'no_hp': noHp,
      'address': address,
      'gender': genderString,
    };

    if(thumbnail != null){
      String thumbnailName = '.${thumbnail.uri.pathSegments.last}';
      MultipartFile multipartFile = await MultipartFile.fromFile(
        thumbnail.path, filename: thumbnailName, contentType: MediaType('image', 'jpg')
      );
      data['thumbnail'] = multipartFile;
    }

    try{
      response = await _dio.put(
        '$_baseUrl/user',
        data: FormData.fromMap(
          data,
        ),
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
        return JSONModel(message: e.toString());
      }
    }
    on Error catch(e){
      return JSONModel(message: e.toString());
    }
    
  }

  ///Active Booking User(Menunjukkan satu booking paling penting)
  Future<JSONModel> getActiveBookingUser() async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    try{
      response = await _dio.get(
        '$_baseUrl/user/bookings/active',
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

  ///Riwayat Booking User(Menunjukkan riwayat booking)
  Future<JSONModel> getRiwayatBookingUser({String filter = 'week', int page = 1}) async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    try{
      response = await _dio.get(
        '$_baseUrl/user/bookings?page=$page&filter=$filter',
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

  ///Detail Booking User
  Future<JSONModel> getDetailBookingUser({required int bookingId}) async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);

    try{
      response = await _dio.get(
        '$_baseUrl/user/bookings/detail/$bookingId',
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