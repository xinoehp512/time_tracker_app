import 'package:flutter/material.dart';
import 'package:time_tracker_app/screens/activity_create_screen.dart';
import 'package:time_tracker_app/screens/activity_overview_screen.dart';
import 'package:time_tracker_app/widgets/clock.dart';

class TimeTrackScreen extends StatelessWidget {
  const TimeTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Time Track App")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Clock(),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, ActivityOverviewScreen.routeName);
                  },
                  child: Text("View Past Activities"))
            ],
          ),
        ),
      ),
    );
  }
}
