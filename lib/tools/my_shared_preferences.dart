import 'package:shared_preferences/shared_preferences.dart';

extension SetSharedPreferences on String{

  ///Set value by using SharedPreferences
  Future<bool> setPref(String key) async => MySharedPreferences.setPref(key, this);
}

class MySharedPreferences{

  static SharedPreferences? _prefs;
  static get prefs => _prefs;
  
  ///Set value by using SharedPreferences
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

  static Future<dynamic> getPref(String key, Type type) async{
    _prefs ??= await SharedPreferences.getInstance();

    switch(type){
      case String : {
        return _prefs!.getString(key);
      }
      
      default : {
        return null;
      }
    }
  }

  ///Remove value that saved from SharedPreferences
  static Future<bool> remove(String key) async{
    _prefs ??= await SharedPreferences.getInstance();

    return await _prefs!.remove(key);
  }

  
  ///'ACCESS_TOKEN'
  static const String accessTokenKey = 'ACCESS_TOKEN';
}