import 'package:flutter/material.dart';
import 'package:time_tracker_app/screens/activity_create_screen.dart';
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
          child: Clock(),
        ),
      ),
    );
  }
}
