class PaymentMethods{
  PaymentMethods({
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

}