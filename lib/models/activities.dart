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

class Activities with ChangeNotifier {
  List<Activity> activities = [Activity("YouTube", Colors.red)];
  List<ActivityLog> activitiesLog = [];
  void addLog(ActivityLog log) {
    activitiesLog.add(log);
    notifyListeners();
  }

  void addActivity(String activityName, int activityColor) {
    activities.add(Activity(activityName, Color(activityColor)));
    notifyListeners();
  }

  void updateActivityLogStartDate(int id, {DateTime? date, TimeOfDay? time}) {
    var log = activitiesLog.firstWhere((element) => element.id == id);
    log.startDate = join(
        date ?? log.startDate, time ?? TimeOfDay.fromDateTime(log.startDate));
    log.length = log.endDate.difference(log.startDate);
    notifyListeners();
  }

  void updateActivityLogEndDate(int id, {DateTime? date, TimeOfDay? time}) {
    var log = activitiesLog.firstWhere((element) => element.id == id);
    log.endDate =
        join(date ?? log.endDate, time ?? TimeOfDay.fromDateTime(log.endDate));
    log.length = log.endDate.difference(log.startDate);
    notifyListeners();
  }

  Activity getActivity(String activityName) {
    return activities.firstWhere((element) => element.name == activityName);
  }
}

DateTime join(DateTime date, TimeOfDay time) {
  return new DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

class ActivityLog {
  static int _nextId = 0;
  static get nextId {
    return _nextId++;
  }

  int id = nextId;
  Activity activity;
  DateTime startDate;
  DateTime endDate;
  Duration length;

  ActivityLog(this.activity, this.startDate, this.endDate, this.length);
}
