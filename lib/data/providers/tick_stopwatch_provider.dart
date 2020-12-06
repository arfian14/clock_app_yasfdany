import 'dart:async';

import 'package:ClockApp/data/models/lap.dart';
import 'package:flutter/material.dart';

class TickStopwatchProvider extends ChangeNotifier {
  DateTime dateTime;
  DateTime lapDateTime;
  int tick = 0;
  int lap = 0;
  Timer timerSub;
  List<Lap> laps = [];
  bool isTicking = false;
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  void resetTimer() {
    tick = 0;
    lap = 0;
    timerSub.cancel();
    isTicking = false;
    laps.clear();
    listKey = GlobalKey<AnimatedListState>();
    notifyListeners();
  }

  void addLap() {
    if (isTicking) {
      Lap currentLap = Lap(lap, tick);
      laps.add(currentLap);
      listKey.currentState.insertItem(laps.length - 1);
      lapDateTime = DateTime.now();
      notifyListeners();
    }
  }

  void pauseTicking() {
    isTicking = false;
    timerSub.cancel();
    notifyListeners();
  }

  void initTicking() {
    if (tick == 0) {
      dateTime = DateTime.now();
    } else {
      dateTime = DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch - tick);
    }

    if (lap == 0) {
      lapDateTime = DateTime.now();
    } else {
      lapDateTime = DateTime.fromMillisecondsSinceEpoch(
          DateTime.now().millisecondsSinceEpoch - lap);
    }
    isTicking = true;
    timerSub = Timer.periodic(Duration(milliseconds: 1), (timer) {
      tick = (DateTime.now().millisecondsSinceEpoch -
              dateTime.millisecondsSinceEpoch)
          .abs();
      lap = (DateTime.now().millisecondsSinceEpoch -
              lapDateTime.millisecondsSinceEpoch)
          .abs();
      notifyListeners();
    });
  }
}
