import 'package:shared_preferences/shared_preferences.dart';

extension SetSharedPreferences on String{
  Future<bool> setPref(String key) async => MySharedPreferences.setPref(key, this) ;
}

class MySharedPreferences{

  static SharedPreferences? _prefs;
  static get prefs => _prefs;

  static Future<bool> setPref(String key, var value) async{

    _prefs ??= await SharedPreferences.getInstance();

    switch(value.runtimeType){
      case String : {
        return await _prefs!.setString(key, value);
      }
      default : {
        return false;
      }
    }
  }

  static Future<bool> remove(String key) async{
    _prefs ??= await SharedPreferences.getInstance();

    return await _prefs!.remove(key);
  }

  
  ///'ACCESS_TOKEN'
  static const String accessTokenKey = 'ACCESS_TOKEN';
}