import 'package:flutter_application_futsal_gembira/service/gate_service.dart';

class InstructionPaymentMethodModel{
  InstructionPaymentMethodModel({
    this.instructionPaymentMethodId,
    this.paymentMethodsId,
    required this.typePaymentMethod,
    required this.instructionPaymentMethodDescription,
  });

  final int? instructionPaymentMethodId;
  final int? paymentMethodsId;
  final String typePaymentMethod;
  final String instructionPaymentMethodDescription;

  factory InstructionPaymentMethodModel.fromJSON(Map<String, dynamic> json, {int? numService}){
    numService ??= GateService.numService;

    switch(numService){

      case 2: {
        return InstructionPaymentMethodModel(
          typePaymentMethod: json['type_payment_method'], 
          instructionPaymentMethodDescription: (json['instruction_payment_method_description'] as String)
              .replaceAll('|', '\n')
        );
      }

      default: {
        return InstructionPaymentMethodModel(
          typePaymentMethod: 'null', 
          instructionPaymentMethodDescription: 'null'
        );
      }
    }
    
  }
}