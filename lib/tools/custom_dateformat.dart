import 'package:intl/intl.dart';

String customDateFormat(DateTime dateTime){
  return DateFormat('d MMMM y; H:mm', 'id_ID').format(dateTime);
}