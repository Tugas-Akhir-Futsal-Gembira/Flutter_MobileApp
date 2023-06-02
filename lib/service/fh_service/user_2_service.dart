import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';

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
  Future<JSONModel> updateProfile({
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
    // Map<String, dynamic> data = {
    //   'name': name,
    //   'no_hp': noHp,
    //   'address': address,
    //   'gender': genderString,
    // };

    // if(thumbnail != null){
    //   print(thumbnail.path);
    //   print(thumbnail.uri.pathSegments);
    //   print(thumbnail.uri.pathSegments.last);
    //   String thumbnailName = '.${thumbnail.uri.pathSegments.last}';
    //   MultipartFile multipartFile = MultipartFile.fromFileSync(
    //     thumbnail.path, 
    //     filename: thumbnailName,
    //     contentType: 
    //   );
    //   // data.update(
    //   //   'thumbnail', 
    //   //   (value) => value, 
    //   //   ifAbsent: () => multipartFile,
    //   // );
    //   data['thumbnail'] = multipartFile;
    // }
    // print(data);

    final FormData formData = FormData();

    // formData.fields
    //     ..add(
    //       MapEntry('name', name),
    //     )
    //     ..add(
    //       MapEntry('no_hp', noHp),
    //     )
    //     ..add(
    //       MapEntry('address', address),
    //     )
    //     ..add(
    //       MapEntry('gender', genderString),
    //     );

    // formData.files.add(
    //   MapEntry(
    //     'thumbnail',
    //     await MultipartFile.fromFile(thumbnail!.path, filename: thumbnail!.uri.pathSegments.last,)
    //   )
    // );
    // print(thumbnail.path);
    // print(formData.files.toString());

    try{
      response = await _dio.put(
        '$_baseUrl/user',
        data: FormData.fromMap(
          {
            'name': name,
            'no_hp': noHp,
            'address': address,
            'gender': genderString,
            'thumbnail': await MultipartFile.fromFile(thumbnail!.path, filename: thumbnail!.uri.pathSegments.last,)
          }
        ),
        options: Options(
          headers: {
            'token': accessToken,
          }
        )
      );

      print(response.data);
      print(response.statusCode);

      return JSONModel.fromJSON(response.data, response.statusCode!);
    }
    on DioError catch(e){
      if(e.response != null){
        print(e.response!.data);
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