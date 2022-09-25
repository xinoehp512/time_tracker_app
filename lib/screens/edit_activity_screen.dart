import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_tracker_app/models/activities.dart';
import 'package:time_tracker_app/widgets/date_time_selector.dart';

class EditActivityScreen extends StatelessWidget {
  const EditActivityScreen({super.key});
  static const routeName = "/edit-activity";

  @override
  Widget build(BuildContext context) {
    var activityLog = ModalRoute.of(context)!.settings.arguments as ActivityLog;
    return Scaffold(
      appBar: AppBar(title: Text("Edit Activity")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: activityLog.activity.color,
                radius: 5,
              ),
              SizedBox(width: 5),
              Text(
                activityLog.activity.name,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Row(
            children: [
              DateTimeSelector(activityLog.startDate, activityLog.setStartDate),
            ],
          )
        ]),
      ),
    );
  }
}
