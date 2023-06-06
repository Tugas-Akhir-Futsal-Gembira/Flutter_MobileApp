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

///Example: 2023-5-19
String customDateFormat3(DateTime dateTime){
  return DateFormat('y-M-d', 'id_ID').format(dateTime);
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

///Example Output: DateTime(2023, 6, 3, 12, 0),
///
///input: '03 Jun 2023, 12:00',
///
///if value = null, return DateTime(0)
DateTime customJsonToDateTime(String? value){

  if(value == null){
    return DateTime(0);
  }

  ///'03'
  String tanggal = value.substring(0, 2);

  ///'Jun'
  String bulan = value.substring(3, 6);

  ///'2023'
  String tahun = value.substring(7, 11);

  ///'12'
  String jam = value.substring(13, 15);

  ///'00'
  String menit = value.substring(16);

  ///Convert from String to int
  
  int? tanggalInt = int.tryParse(tanggal);
  tanggalInt ??= 1;

  int? bulanInt;

  List<String> bulanString = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
  ];

  for(int i = 0; i < bulanString.length; i++){
    if(bulan == bulanString[i]){
      bulanInt = i + 1;
      break;
    }
  }
  bulanInt ??= 1;

  int? tahunInt = int.tryParse(tahun);
  tahunInt ??= 0;

  int? jamInt = int.tryParse(jam);
  jamInt ??= 0;

  int? menitInt = int.tryParse(menit);
  menitInt ??= 0;

  return DateTime(
    tahunInt, 
    bulanInt, 
    tanggalInt,
    jamInt,
    menitInt
  );
  
}

///Example: 'Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu
String customActiveDaysString(List<String> listDays){
  String returnStr = '';
  for(int i = 0; i < listDays.length; i++){
    if(i != listDays.length - 1){
      returnStr += '${listDays[i]}, ';
    }
    else{
      returnStr += listDays[i];
    }
  }

  return returnStr;
}