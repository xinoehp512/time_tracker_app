import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/models/activities.dart';

import '../providers/timer.dart';
import '../screens/activity_create_screen.dart';

//Starts and keeps track of activities.
class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String? activityName;
  @override
  Widget build(BuildContext context) {
    var timer = Provider.of<Timer>(context);
    var activities = Provider.of<Activities>(context, listen: false);
    var activity =
        activityName == null ? null : activities.getActivity(activityName!);
    return timer.time == null
        ? Column(
            children: [
              //Takes the user to the activity create screen.
              ElevatedButton(
                child: Text("Start Activity"),
                onPressed: () => Navigator.of(context)
                    .pushNamed(ActivityCreateScreen.routeName)
                    .then((Object? name) =>
                        startActivity(name as String?, timer)),
              ),
              //Displays the user's most recently used activities. Clicking on an activity will automatically start it.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: activities.recentActivities
                    .map((act) => OutlinedButton(
                        onPressed: () {
                          startActivity(act.name, timer);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: act.color,
                              radius: 5,
                            ),
                            SizedBox(width: 5),
                            Text(
                              act.name,
                            ),
                          ],
                        )))
                    .toList(),
              )
            ],
          )
        //Displays the amount of time the activity has been active for.
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${timer.time!.inHours > 0 ? "${timer.time!.inHours} hours, " : " "}${timer.time!.inMinutes.remainder(60)} minutes",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Activity: "),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: activity!.color,
                  ),
                  SizedBox(width: 5),
                  Text(activityName!),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => endActivity(activity, timer),
                  child: Text("End Activity"))
            ],
          );
  }

  startActivity(String? name, Timer timer) {
    if (name == null) {
      return;
    }
    activityName = name;
    timer.startTimer();
  }

  endActivity(Activity activity, Timer timer) {
    timer.endTimer();
    final log = ActivityLog(
      activity,
      timer.lastStartDate!,
      timer.lastEndDate!,
      timer.lastDuration!,
    );

    var activities = Provider.of<Activities>(context, listen: false);
    activities.addLog(log);
  }
}
