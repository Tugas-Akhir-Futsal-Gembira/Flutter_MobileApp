import 'package:flutter_application_futsal_gembira/service/gate_service.dart';

class ProfileModel{
  ProfileModel({
    required this.id,
    required this.idUnik,
    required this.name,
    required this.email,
    required this.type,
    required this.phone,
    required this.address,
    required this.thumbnail,
    required this.gender,
  });

  final int id;
  String? idUnik;
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
          idUnik: json['idUser'],
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

      case 2: {
        // return ProfileModel(
        //   id: json['user_id'], 
        //   idUnik: '@${json['username']}',
        //   name: json['name'],
        //   email: json['email'], 
        //   type: json['type'], 
        //   phone: json['no_hp'], 
        //   address: json['alamat'], 
        //   thumbnail: json['thumbnail'],
        //   gender: json['gender'],
        // );

        return ProfileModel(
          id: 0,
          idUnik: null,
          name: 'null',
          email: 'null', 
          type: 'null', 
          phone: 'null', 
          address: null, 
          thumbnail: null,
          gender: null,
        );
      }

      default: {
        return ProfileModel(
          id: 0,
          idUnik: null,
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