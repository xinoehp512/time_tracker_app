import 'dart:async' as async;

import 'package:flutter/material.dart';

class Timer with ChangeNotifier {
  final stopwatch = CustomStopwatch();
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

class CustomStopwatch {
  DateTime? startTime;
  DateTime? stopTime;
  bool active = false;

  void start() {
    if (active == false) {
      startTime = DateTime.now();
    }
    active = true;
  }

  void stop() {
    if (active == true) {
      stopTime = DateTime.now();
    }
    active = false;
  }

  void reset() {
    startTime = null;
    stopTime = null;
    active = false;
  }

  Duration get elapsed {
    if (active) {
      return DateTime.now().difference(startTime!);
    } else if (stopTime != null) {
      return stopTime!.difference(startTime!);
    } else {
      return Duration();
    }
  }

  int get elapsedMilliseconds {
    return elapsed.inMilliseconds;
  }
}
