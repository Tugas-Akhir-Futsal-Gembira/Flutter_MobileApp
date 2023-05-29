class JSONModel{

  JSONModel({this.status, required this.message, this.data, this.errors, this.statusCode});

  final String? status;
  final String? message;
  final Map<String, dynamic>? data;
  final List<String>? errors;
  final int? statusCode;


  String? toString1(){
    return {
      'status': status,
      'message': message,
      'data': data.toString(),
      'statusCode': statusCode.toString(),
      'errors': errors.toString()
    }.toString();
  }

  String getErrorToString(){
    if(errors != null){
      return 'Status Code: $statusCode\nError: $errors';
    }

    return 'Status Code: $statusCode\nMessage: ${message.toString()}';
  }

  ///Primarily json receive Map<String, dynamic> but json might receive String because of error message received from response
  factory JSONModel.fromJSON(dynamic json, int statusCode){

    // print(json.toString());

    Map<String, dynamic> tempJson;
    if(json.runtimeType == String){
      tempJson = {
        'message': json
      };
    }
    else {
      tempJson = json;
    }

    return JSONModel(
      status: (tempJson['status']).toString(), 
      message: tempJson['message'],
      data: tempJson['data'],
      errors: (tempJson['errors'] as List?)?.map((item) => item as String).toList(),
      statusCode: statusCode,
    );
  }

}