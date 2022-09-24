import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/timer.dart';
import '../screens/activity_create_screen.dart';

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
    return timer.time == null
        ? ElevatedButton(
            child: Text("Start Activity"),
            onPressed: () => Navigator.of(context)
                .pushNamed(ActivityCreateScreen.routeName)
                .then((Object? name) => startActivity(name as String?, timer)),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(timer.time.toString()),
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
}
