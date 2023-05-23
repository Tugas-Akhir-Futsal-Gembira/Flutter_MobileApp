String obscureText(String value, {bool isObscured = true}){
  
  if(!isObscured){
    return value;
  }

  ///else
  String returnText = '';
  for(int i = 0; i < value.length; i++){
    returnText += '*';
  }
  return returnText;
}