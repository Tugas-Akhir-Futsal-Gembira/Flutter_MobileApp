class InstructionPaymentMethodModel{
  InstructionPaymentMethodModel({
    required this.instructionPaymentMethodId,
    required this.paymentMethodsId,
    required this.typePaymentMethod,
    required this.instructionPaymentMethodDescription,
  });

  final int instructionPaymentMethodId;
  final int paymentMethodsId;
  final String typePaymentMethod;
  final String instructionPaymentMethodDescription;
}