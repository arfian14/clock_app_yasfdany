import 'dart:convert';

import 'package:ClockApp/data/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmProvider extends ChangeNotifier {
  List<Alarm> alarms = [];

  void replaceAlarm(Alarm oldValue, Alarm value) {
    int currentIndex = alarms.indexOf(oldValue);
    alarms.removeAt(currentIndex);
    alarms.insert(currentIndex, value);

    saveAlarms();
    notifyListeners();
  }

  void switchAlarm(Alarm oldValue, bool active) {
    alarms[alarms.indexOf(oldValue)].active = active;
    saveAlarms();
    notifyListeners();
  }

  void removeAlarm(Alarm value) {
    alarms.remove(value);
    saveAlarms();
    notifyListeners();
  }

  void addAlarm(Alarm value) {
    alarms.add(value);
    saveAlarms();
    notifyListeners();
  }

  void saveAlarms() async {
    await SharedPreferences.getInstance().then((prefs) {
      List<String> alarmString = [];
      for (Alarm alarm in alarms) {
        alarmString.add(jsonEncode(alarm.toJson()));
      }
      prefs.setStringList("alarms", alarmString);
    });
  }

  void loadAlarms() async {
    await SharedPreferences.getInstance().then((prefs) {
      var prefAlarms = prefs.getStringList("alarms");
      if (prefAlarms != null) {
        alarms.clear();
        for (String alarmString in prefAlarms) {
          Alarm alarm = Alarm.fromJson(jsonDecode(alarmString));
          alarms.add(alarm);
        }
      }

      notifyListeners();
    });
  }
}
