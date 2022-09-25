import 'dart:async' as async;

import 'package:flutter/material.dart';

class Timer with ChangeNotifier {
  final stopwatch = Stopwatch();
  DateTime? lastStartDate;
  DateTime? lastEndDate;
  Duration? lastDuration;
  void startTimer() {
    stopwatch.start();
    lastStartDate = DateTime.now();
    async.Timer.periodic(Duration(seconds: 1), (timer) => updateTimer());
    notifyListeners();
  }

  void endTimer() {
    lastDuration = stopwatch.elapsed;
    lastEndDate = DateTime.now();

    stopwatch.stop();
    stopwatch.reset();
  }

  void updateTimer() {
    notifyListeners();
  }

  Duration? get time {
    if (stopwatch.elapsedMilliseconds == 0) {
      return null;
    }
    return stopwatch.elapsed;
  }
}
