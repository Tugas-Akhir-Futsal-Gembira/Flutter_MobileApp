abstract class AbstractPenyewaanModel{
  AbstractPenyewaanModel({
    required this.fieldName,
    required this.rentDateTime,
    required this.durationInt,
    required this.createdAtDateTime,
  });

  final String fieldName;
  final DateTime rentDateTime;
  final int durationInt;
  final DateTime createdAtDateTime;
}