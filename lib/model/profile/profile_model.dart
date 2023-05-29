import 'package:flutter_application_futsal_gembira/service/gate_service.dart';

class ProfileModel{
  ProfileModel({
    required this.id,
    this.idUser,
    required this.name,
    required this.email,
    required this.type,
    required this.phone,
    required this.address,
    required this.thumbnail,
    required this.gender,
  });

  final int id;
  String? idUser;
  final String name;
  final String email;
  final String type;
  final String phone;
  final String? address;
  final String? thumbnail;
  final String? gender;

  factory ProfileModel.fromJSON(Map<String, dynamic> json, {int? numService}){
    numService ??= GateService.numService;
    
    switch(numService){
      case 1: {
        return ProfileModel(
          id: json['id'], 
          idUser: json['idUser'],
          // name: json['name'],
          name: 'Edit ProfileModel',
          email: json['email'], 
          type: json['type'], 
          phone: json['phone'], 
          address: json['address'], 
          thumbnail: json['thumbnail'],
          gender: json['gender'],
        );
      }

      default: {
        return ProfileModel(
          id: 0,
          idUser: null,
          name: 'null',
          email: 'null', 
          type: 'null', 
          phone: 'null', 
          address: null, 
          thumbnail: null,
          gender: null,
        );
      }
    }
  }
}