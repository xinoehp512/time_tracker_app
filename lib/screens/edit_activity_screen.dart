import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/models/activities.dart';
import 'package:time_tracker_app/widgets/date_time_selector.dart';

class EditActivityScreen extends StatelessWidget {
  const EditActivityScreen({super.key});
  static const routeName = "/edit-activity";

  @override
  Widget build(BuildContext context) {
    var activityLog = ModalRoute.of(context)!.settings.arguments as ActivityLog;
    var activities = Provider.of<Activities>(context);
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
              Text("Start Date:"),
              DateTimeSelector(activityLog.startDate, ({date, time}) {
                activities.updateActivityLogStartDate(
                  activityLog.id,
                  date: date,
                  time: time,
                );
              }),
            ],
          ),
          Row(
            children: [
              Text("End Date:"),
              DateTimeSelector(activityLog.endDate, ({date, time}) {
                activities.updateActivityLogEndDate(
                  activityLog.id,
                  date: date,
                  time: time,
                );
              }),
            ],
          ),
          Row(
            children: [
              Text("Duration: ${activityLog.length.inMinutes} minutes"),
            ],
          )
        ]),
      ),
    );
  }
}
