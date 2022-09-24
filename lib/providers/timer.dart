import 'dart:async' as async;

import 'package:flutter/material.dart';

class Timer with ChangeNotifier {
  DateTime? _startTime;
  void startTimer() {
    _startTime = DateTime.now();
    async.Timer.periodic(Duration(seconds: 1), (timer) => updateTimer());
    notifyListeners();
  }

  void updateTimer() {
    notifyListeners();
  }

  Duration? get time {
    if (_startTime == null) {
      return null;
    }
    return DateTime.now().difference(_startTime!);
  }
}
