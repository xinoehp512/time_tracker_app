import 'package:flutter/material.dart';
import 'package:time_tracker_app/helpers/db_helper.dart';

class Activity {
  final String name;
  final Color color;
  Duration _totalTimeSpent = Duration(minutes: 0);

  Activity(this.name, this.color);

  Map<String, Object> toMap() {
    return {
      "name": name,
      "color": color.value,
    };
  }
}

class Activities with ChangeNotifier {
  List<Activity> activities = [];
  List<ActivityLog> activitiesLog = [];

  Future<void> fetchAndSetActivities() async {
    var activityData = await DBHelper.getData("activities");
    activities = activityData.map((element) {
      return Activity(element["name"], Color(element["color"]));
    }).toList();
    var logData = await DBHelper.getData("logs");
    activitiesLog =
        logData.map((element) => ActivityLog.fromMap(element, this)).toList();
  }

  void sortActivities() {
    activitiesLog.sort(
      (a, b) {
        if (a.startDate.isBefore(b.startDate)) {
          return -1;
        }

        return 1;
      },
    );
  }

  void addLog(ActivityLog log) {
    activitiesLog.add(log);
    DBHelper.insert("logs", log.toMap());
    notifyListeners();
  }

  List<Activity> get recentActivities {
    List<Activity> recentActivities = [];
    sortActivities();
    for (var activity in activitiesLog.reversed) {
      if (!recentActivities.contains(activity.activity)) {
        recentActivities.add(activity.activity);
      }
    }
    return recentActivities.length > 5
        ? recentActivities.sublist(0, 5)
        : recentActivities;
  }

  void addActivity(String activityName, int activityColor) {
    var activity = Activity(activityName, Color(activityColor));
    activities.add(activity);
    DBHelper.insert("activities", activity.toMap());
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

  int id = DateTime.now().millisecondsSinceEpoch;
  Activity activity; //Perhaps refactor such that this is an ID, not direct link
  DateTime startDate;
  DateTime endDate;
  Duration length;

  TimeOfDay get startTime {
    return TimeOfDay.fromDateTime(startDate);
  }

  TimeOfDay get endTime {
    return TimeOfDay.fromDateTime(endDate);
  }

  ActivityLog(this.activity, this.startDate, this.endDate, this.length);

  Map<String, Object> toMap() {
    return {
      "id": id,
      "activity": activity.name,
      "startDate": startDate.millisecondsSinceEpoch,
      "endDate": endDate.millisecondsSinceEpoch,
      "length": length.inSeconds
    };
  }

  static ActivityLog fromMap(Map<String, dynamic> map, Activities activities) {
    var activity = activities.getActivity(map["activity"]);
    var startDate = DateTime.fromMillisecondsSinceEpoch(map["startDate"]);
    var endDate = DateTime.fromMillisecondsSinceEpoch(map["endDate"]);
    var length = Duration(seconds: map["length"]);
    var log = ActivityLog(activity, startDate, endDate, length);
    log.id = map["id"];
    return log;
  }
}
