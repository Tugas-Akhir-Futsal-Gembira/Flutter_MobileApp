import 'package:dio/dio.dart';
import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_dateformat.dart';
import 'package:flutter_application_futsal_gembira/tools/custom_url.dart';
import 'package:flutter_application_futsal_gembira/tools/my_shared_preferences.dart';

class Booking2Service{

  final Dio _dio = Dio();
  final String _baseUrl = CustomUrl.fhUrl;

  ///AvailableField
  Future<JSONModel> getAvailableField({
    required int fieldId,
    required DateTime date,
  }) async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);
    
    String dateString = customDateFormat3(date);

    try{
      response = await _dio.get(
        '$_baseUrl/bookings/field/$fieldId?date=$dateString',
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

  ///Booking Mobile
  Future<JSONModel> postBookingMobile({
    required int fieldId,
    required DateTime bookingDate,
    required int bookingTime,
    required int duration,
    required int paymentMethodId,
  }) async{

    Response response;
    String accessToken = await MySharedPreferences.getPref(MySharedPreferences.accessTokenKey, String);
    
    String bookingDateString = customDateFormat3(bookingDate);
    String bookingTimeString = customTimeFormat(bookingTime, 0);

    try{
      response = await _dio.post(
        '$_baseUrl/bookings/mobile',
        data: {
          'field_id': fieldId,
          'booking_date': bookingDateString,
          'booking_time': bookingTimeString,
          'duration': duration,
          'payment_method_id': paymentMethodId,
        },
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