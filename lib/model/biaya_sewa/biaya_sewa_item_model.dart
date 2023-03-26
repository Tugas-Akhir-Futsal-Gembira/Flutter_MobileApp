class BiayaSewaItemModel{
  BiayaSewaItemModel({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  }){
    totalUnitPrice = unitPrice * quantity;
  }

  final String description;
  final int quantity;
  final double unitPrice;
  late final double totalUnitPrice;
}