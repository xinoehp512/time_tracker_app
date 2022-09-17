import 'package:flutter/material.dart';

class Activity {
  final String name;
  final Color color;
  int _count = 0;
  get count {
    return _count;
  }

  void performActivity() {
    _count++;
  }

  Activity(this.name, this.color);
}

class Activities {
  static List<Activity> activities = [Activity("YouTube", Colors.red)];

  static void addActivity(String activityName, int activityColor) {
    activities.add(Activity(activityName, Color(activityColor)));
  }
}
