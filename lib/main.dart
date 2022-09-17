import 'package:flutter/material.dart';
import 'package:time_tracker_app/screens/activity_create_screen.dart';
import 'package:time_tracker_app/screens/time_track_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimeTrackScreen(),
      routes: {
        ActivityCreateScreen.routeName: (context) => ActivityCreateScreen(),
      },
    );
  }
}
