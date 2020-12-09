import 'dart:async';
import 'package:flutter/material.dart';

class TickTimerProvider extends ChangeNotifier {
  DateTime dateTime;
  int timer = 0;
  int tick = 0;

  Timer timerSub;
  bool isTicking = false;

  void setTimer(int value) {
    timer = value;
    notifyListeners();
  }

  void resetTimer() {
    tick = 0;
    timer = 0;
    timerSub.cancel();
    isTicking = false;
    notifyListeners();
  }

  void pauseTicking() {
    isTicking = false;
    timerSub.cancel();
    notifyListeners();
  }

  void initTicking() {
    dateTime = DateTime.now();

    isTicking = true;
    timerSub = Timer.periodic(Duration(milliseconds: 1), (time) {
      tick = DateTime.now().millisecondsSinceEpoch -
          dateTime.millisecondsSinceEpoch;

      if ((timer - tick).isNegative) {
        resetTimer();
      }
      notifyListeners();
    });
  }
}
