import 'dart:io';

import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/service/fh_service/auth_2_service.dart';
import 'package:flutter_application_futsal_gembira/service/fh_service/booking_2_service.dart';
import 'package:flutter_application_futsal_gembira/service/fh_service/field_2_service.dart';
import 'package:flutter_application_futsal_gembira/service/fh_service/payment_2_service.dart';
import 'package:flutter_application_futsal_gembira/service/fh_service/user_2_service.dart';
import 'package:flutter_application_futsal_gembira/service/futsal_gembira_service/auth_1_service.dart';

class GateService{

  ///Choose Service (default = 1)
  static const int _numService = 2;
  static get numService => _numService;

  static final Auth1Service _auth1service = Auth1Service();

  static final Auth2Service _auth2service = Auth2Service();
  static final User2Service _user2service = User2Service();
  static final Field2Service _field2service = Field2Service();
  static final Payment2Service _payment2service = Payment2Service();
  static final Booking2Service _booking2service = Booking2Service();

  ///Register
  static Future<JSONModel> postRegister({
    required String username,
    required String email,
    required String password,
    required String phone,
    int? numService = _numService,
  }) async{
    
    JSONModel json;

    switch(numService){
      case 1 : {
        json = await _auth1service.postRegister(
          username: username, 
          email: email, 
          password: password, 
          phone: phone
        );
        break;
      }

      case 2 : {
        json = await _auth2service.postRegister(
          name: username, 
          email: email, 
          noHp: phone, 
          password: password, 
          confirmPassword: password, 
          fcmToken: 'Dummy String'
        );
        break;
      }

      default : {
        json = JSONModel(message: 'Error on Post Register: Switch Case Default');
      }
    }
    return json;
  }

  ///Login
  static Future<JSONModel> postLogin({
    required String email,
    required String password,
    required String fcmToken,
    int? numService = _numService,
  }) async{
    
    JSONModel json;

    switch(numService){
      case 1: {
        json = await _auth1service.postLogin(email: email, password: password, fcmToken: fcmToken);
        break;
      }

      case 2: {
        json = await _auth2service.postLogin(email: email, password: password, fcmToken: fcmToken);
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Post Login: Switch Case Default');
      }
    }
    return json;
  }


  ///Reset Password
  static Future<JSONModel> postResetPassword({
    required String email,
    int? numService = _numService
  }) async{
    
    JSONModel json;

    switch(numService){
      case 1: {
        json = await _auth1service.postResetPassword(email: email);
        break;
      }

      case 2: {
        json = await _auth2service.postOTP(email: email);
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Post Reset Password: Switch Case Default');
      }
    }
    return json;
  }

  ///Update Password
  static Future<JSONModel> patchUpdatePassword({
    required String email,
    required String code,
    required String password,
    int? numService = _numService
  }) async{
    
    JSONModel json;

    switch(numService){
      case 1: {
        json = await _auth1service.patchUpdatePassword(email: email, code: code, password: password);
        break;
      }

      case 2: {
        json = await _auth2service.putForgotPassword(
          email: email, code: code, password: password, confirmPassword: password
        );
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Patch Update Password: Switch Case Default');
      }
    }

    return json;
  }

  ///Me
  static Future<JSONModel> getMe({
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      case 1: {
        json = await _auth1service.getMe();
        break;
      }

      case 2: {
        json = await _user2service.getProfile();
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get Me: Switch Case Default');
      }
    }

    return json;
  }

  ///Update Profile
  static Future<JSONModel> putUpdateProfile({
    required String name,
    required String noHp,
    required String address,
    required int gender,
    File? thumbnail,
    int? numService = _numService,
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _user2service.putUpdateProfile(
          name: name, 
          noHp: noHp, 
          address: address, 
          gender: gender, 
          thumbnail: thumbnail
        );
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Put Update Profile: Switch Case Default');
      }
    }

    return json;
  }

  ///Active Booking User(Menunjukkan satu booking paling penting)
  static Future<JSONModel> getActiveBookingUser({
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _user2service.getActiveBookingUser();
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get Active Booking User: Switch Case Default');
      }
    }

    return json;
  }

  ///List Fields
  static Future<JSONModel> getListFields({
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _field2service.getListFields();
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get List Fields: Switch Case Default');
      }
    }

    return json;
  }

  ///Riwayat Booking User(Menunjukkan riwayat booking)
  static Future<JSONModel> getRiwayatBookingUser({
    int page = 1,
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _user2service.getRiwayatBookingUser(page: page);
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get Riwayat Booking User: Switch Case Default');
      }
    }

    return json;
  }

  ///Detail Field
  static Future<JSONModel> getDetailField({
    required int id,
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _field2service.getDetailField(id: id);
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get Deail Field: Switch Case Default');
      }
    }

    return json;
  }

  ///List Payment
  static Future<JSONModel> getListPayment({
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _payment2service.getListPayment();
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get List Payment: Switch Case Default');
      }
    }

    return json;
  }

  ///Available Field
  static Future<JSONModel> getAvailableField({
    required int fieldId,
    required DateTime date,
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _booking2service.getAvailableField(fieldId: fieldId, date: date);
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get Available Field: Switch Case Default');
      }
    }

    return json;
  }

  
  ///Booking Mobile
  static Future<JSONModel> postBookingMobile({
    required int fieldId,
    required DateTime bookingDate,
    required int bookingTime,
    required int duration,
    required int paymentMethodId,
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _booking2service.postBookingMobile(
          fieldId: fieldId, 
          bookingDate: bookingDate, 
          bookingTime: bookingTime, 
          duration: duration, 
          paymentMethodId: paymentMethodId
        );
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Post Booking Mobile: Switch Case Default');
      }
    }

    return json;
  }

  ///Detail Booking User
  static Future<JSONModel> getDetailBookingUser({
    required int bookingId,
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _user2service.getDetailBookingUser(bookingId: bookingId);
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get Detail Booking User: Switch Case Default');
      }
    }

    return json;
  }

  ///Tutorial Payment
  static Future<JSONModel> getTutorialPayment({
    required int paymentMethodId,
    required String kodePembayaran,
    int numService = _numService
  }) async{

    JSONModel json;

    switch(numService){
      // case 1: {
      //   json = await _auth1service.getMe();
      //   break;
      // }

      case 2: {
        json = await _payment2service.getTutorialPayment(paymentMethodId: paymentMethodId, kodePembayaran: kodePembayaran);
        break;
      }

      default: {
        json = JSONModel(message: 'Error on Get Tutorial Payment: Switch Case Default');
      }
    }

    return json;
  }

}