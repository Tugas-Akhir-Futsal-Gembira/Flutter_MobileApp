import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/service/fh_service/auth_2_service.dart';
import 'package:flutter_application_futsal_gembira/service/futsal_gembira_service/auth_1_service.dart';

class GateService{

  ///Choose Service (default = 1)
  static const int _numService = 1;

  static final Auth1Service _auth1service = Auth1Service();

  static final Auth2Service _auth2service = Auth2Service();

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

      default: {
        json = JSONModel(message: 'Error on Post Login: Switch Case Default');
      }
    }
    return json;
  }


  

}