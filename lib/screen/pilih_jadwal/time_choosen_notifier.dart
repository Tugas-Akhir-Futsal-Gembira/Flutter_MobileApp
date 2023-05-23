import 'package:flutter/material.dart';

class TimeChoosen{
  TimeChoosen({this.startHour, this.duration, this.paymentMethodIsChoosen = false});

  int? startHour;
  int? duration;
  bool paymentMethodIsChoosen;
  int? dayDuration;
  int? nightDuration;

  ///Seperate day and night duration
  void setDayNight(int? startHour, int? duration, int? nightHour){

    if(startHour != null && duration != null){
      ///If nightHour not specified
      if(nightHour == null){
        dayDuration = duration;
        nightDuration = null;
      }
      ///If nightHour specified
      else{
        ///If startHour is in day
        if(startHour < nightHour){
          ///Hours count from startHour(Day) to nightHour
          int startHourToNightHourInHours = nightHour - startHour;
          if(startHourToNightHourInHours >= duration){
            dayDuration = duration;
            nightDuration = null;
          }
          else{
            dayDuration = startHourToNightHourInHours;
            nightDuration = duration - startHourToNightHourInHours;
          }
        }
        ///If startHour is in night
        else{
          nightDuration = duration;
          dayDuration = null;
        }
      }
    }
    else{
      dayDuration = null;
      nightDuration = null;
    }
  }
}

class TimeChoosenNotifier extends ValueNotifier<TimeChoosen>{
  TimeChoosenNotifier(this._value) : super(_value);

  final TimeChoosen _value;

  ///Starting hour choosen
  int? get startHour => _value.startHour;
  ///Total duration (day and night combined)
  int? get duration => _value.duration;
  bool get paymentMethodIsChoosen => _value.paymentMethodIsChoosen;
  int? get dayDuration => _value.dayDuration;
  int? get nightDuration => _value.nightDuration;
  
  void setTimeData(int? startHour, int? duration, int? nightHour){
    _value.startHour = startHour;
    _value.duration = duration;

    _value.setDayNight(startHour, duration, nightHour);
    notifyListeners();
  }

  void setPaymentMethodIsChoosen(bool paymentMethodIsChoosen){
    _value.paymentMethodIsChoosen = paymentMethodIsChoosen;
    notifyListeners();
  }
}
