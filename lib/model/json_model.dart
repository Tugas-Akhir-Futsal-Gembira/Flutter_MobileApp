class JSONModel{

  JSONModel({this.status, required this.message, this.data, this.statusCode});

  final String? status;
  final String? message;
  final Map<String, dynamic>? data;
  final int? statusCode;


  String? toString1(){
    return {
      'status': status,
      'message': message,
      'data': data.toString(),
      'statusCode': statusCode.toString()
    }.toString();
  }

  ///Primarily json receive Map<String, dynamic> but json might receive String because of error message received from response
  factory JSONModel.fromJSON(dynamic json, int statusCode){

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
      statusCode: statusCode,
    );
  }

}