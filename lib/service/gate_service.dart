import 'package:flutter_application_futsal_gembira/model/json_model.dart';
import 'package:flutter_application_futsal_gembira/service/fh_service/auth_2_service.dart';
import 'package:flutter_application_futsal_gembira/service/futsal_gembira_service/auth_1_service.dart';

class GateService{

  ///Choose Service (default = 1)
  static const int _numService = 1;

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
        Auth1Service service = Auth1Service();
        json = await service.postRegister(
          username: username, 
          email: email, 
          password: password, 
          phone: phone
        );
        break;
      }

      case 2 : {
        Auth2Service service = Auth2Service();
        json = await service.postRegister(
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
        json = JSONModel(message: 'Error');
      }
    }

    return json;

  }


  

}