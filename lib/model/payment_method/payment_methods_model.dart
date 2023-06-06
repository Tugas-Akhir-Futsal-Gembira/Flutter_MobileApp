import 'package:flutter_application_futsal_gembira/service/gate_service.dart';

class PaymentMethodsModel{
  PaymentMethodsModel({
    required this.paymentMethodsId,
    required this.logo,
    required this.paymentMethodName,
    this.paymentTypes,
    this.paymentAdminPercent,
    this.paymentAdminNominal
  });

  final int paymentMethodsId;
  final String? paymentTypes;
  final String logo;
  final String paymentMethodName;
  final int? paymentAdminPercent;
  final int? paymentAdminNominal;

  factory PaymentMethodsModel.fromJSON(Map<String, dynamic> json, {int? numService}) {
    numService ??= GateService.numService;

    return PaymentMethodsModel(
      paymentMethodsId: json['payment_method_id'], 
      logo: json['logo'], 
      paymentMethodName: json['payment_method_name'],
      paymentAdminNominal: json['payment_admin_nominal'],
    );
  }

}