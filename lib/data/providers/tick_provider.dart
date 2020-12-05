import 'dart:async';

import 'package:flutter/material.dart';

class TickProvider extends ChangeNotifier {
  var dateTime = DateTime.now();

  void initTicking() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      dateTime = DateTime.now();
      notifyListeners();
    });
  }
}
