import 'package:flutter/material.dart';

class Activity {
  final String name;
  final Color color;
  int _count = 0;
  Duration _totalTimeSpent = Duration(minutes: 0);
  get count {
    return _count;
  }

  void logActivity() {
    _count++;
  }

  Activity(this.name, this.color);
}

class Activities {
  static List<Activity> activities = [Activity("YouTube", Colors.red)];

  static void addActivity(String activityName, int activityColor) {
    activities.add(Activity(activityName, Color(activityColor)));
  }

  static Activity getActivity(String activityName) {
    return activities.firstWhere((element) => element.name == activityName);
  }
}

class ActivityLog {
  Activity activity;
  DateTime _startDate;
  DateTime get startDate => _startDate;
  DateTime _endDate;
  DateTime get endDate => _endDate;
  Duration length;

  ActivityLog(this.activity, this._startDate, this._endDate, this.length);

  void setStartDate({DateTime? date, TimeOfDay? time}) {
    _startDate =
        join(date ?? startDate, time ?? TimeOfDay.fromDateTime(startDate));
    length = endDate.difference(startDate);
  }

  void setEndDate({DateTime? date, TimeOfDay? time}) {
    _endDate = join(date ?? endDate, time ?? TimeOfDay.fromDateTime(endDate));
    length = endDate.difference(startDate);
  }

  DateTime join(DateTime date, TimeOfDay time) {
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }
}

class ActivitiesLog {
  static List<ActivityLog> activitiesLog = [];
  static void addLog(ActivityLog log) {
    activitiesLog.add(log);
  }
}
