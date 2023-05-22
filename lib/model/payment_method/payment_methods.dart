class PaymentMethods{
  PaymentMethods({
    required this.paymentMethodsId,
    required this.logo,
    required this.paymentMethodName,
    this.paymentTypes,
    this.ppnPercent,
    this.ppnNominal
  });

  final int paymentMethodsId;
  final String? paymentTypes;
  final String logo;
  final String paymentMethodName;
  final int? ppnPercent;
  final int? ppnNominal;

}