import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimezoneProvider extends ChangeNotifier {
  List<String> timeZones = [
    "Asia/Jakarta",
    "Asia/Pontianak",
    "Asia/Makassar",
    "Asia/Jayapura",
  ];

  void replaceTimezone(String oldValue, String value) {
    int currentIndex = timeZones.indexOf(oldValue);
    timeZones.removeAt(currentIndex);
    timeZones.insert(currentIndex, value);

    saveTimezones();
    notifyListeners();
  }

  void removeTimezone(String value) {
    timeZones.remove(value);
    saveTimezones();
    notifyListeners();
  }

  void addTimezone(String value) {
    timeZones.add(value);
    saveTimezones();
    notifyListeners();
  }

  void saveTimezones() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList("timezones", timeZones);
    });
  }

  void loadTimezones() async {
    await SharedPreferences.getInstance().then((prefs) {
      var prefTimezones = prefs.getStringList("timezones");
      if (prefTimezones != null) {
        if (prefTimezones.isNotEmpty) {
          timeZones.clear();
          timeZones.addAll(prefTimezones);
        }
      }

      notifyListeners();
    });
  }
}
