import 'package:intl/intl.dart';

//usage -> numFormat.format(12345);
NumberFormat numFormat = NumberFormat('00');

///Example: 19 Mei 2023, 19:06
String customDateFormat(DateTime dateTime){
  return DateFormat('d MMMM y, H:mm', 'id_ID').format(dateTime);
}

///Example: Jumat, 19 Mei 2023
String customDateFormat2(DateTime dateTime){
  return DateFormat('EEEE, d MMMM y', 'id_ID').format(dateTime);
}

///Example: 07:00
String customTimeFormat(
  int timeHour, 
  int timeMinute,
){
  String timeFormatted = '${numFormat.format(timeHour)}:${numFormat.format(timeMinute)}';
  return timeFormatted;
}

///Example: Rp 20.000,00
String customCurrencyFormat(int totalCurrency, { int decimalDigits = 0, bool withSymbol = true }){
  NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id_ID', 
    symbol: (withSymbol) ? 'Rp ' : '', 
    decimalDigits: decimalDigits
  );
  return currencyFormat.format(totalCurrency);
}