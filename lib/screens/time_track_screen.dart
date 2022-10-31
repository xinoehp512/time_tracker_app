import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/models/activities.dart';
import 'package:time_tracker_app/screens/activity_create_screen.dart';
import 'package:time_tracker_app/screens/activity_overview_screen.dart';
import 'package:time_tracker_app/screens/splash_screen.dart';
import 'package:time_tracker_app/widgets/clock.dart';

class TimeTrackScreen extends StatefulWidget {
  const TimeTrackScreen({super.key});

  @override
  State<TimeTrackScreen> createState() => _TimeTrackScreenState();
}

class _TimeTrackScreenState extends State<TimeTrackScreen> {
  late Future activitiesFuture;
  @override
  void initState() {
    var activities = Provider.of<Activities>(context, listen: false);
    activitiesFuture = activities.fetchAndSetActivities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: activitiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (snapshot.hasError) {
            print(snapshot.error);
          }
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
        });
  }
}
