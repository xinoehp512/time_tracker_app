import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/models/activities.dart';
import 'package:time_tracker_app/providers/timer.dart';
import 'package:time_tracker_app/screens/activity_create_screen.dart';
import 'package:time_tracker_app/screens/activity_overview_screen.dart';
import 'package:time_tracker_app/screens/edit_activity_screen.dart';
import 'package:time_tracker_app/screens/time_track_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Timer>(create: (context) => Timer()),
        ChangeNotifierProvider<Activities>(create: (context) => Activities()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TimeTrackScreen(),
        routes: {
          ActivityCreateScreen.routeName: (context) => ActivityCreateScreen(),
          ActivityOverviewScreen.routeName: (context) =>
              ActivityOverviewScreen(),
          EditActivityScreen.routeName: (context) => EditActivityScreen(),
        },
      ),
    );
  }
}
