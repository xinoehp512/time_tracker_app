import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/models/activities.dart';
import 'package:time_tracker_app/screens/edit_activity_screen.dart';

class ActivityOverviewScreen extends StatelessWidget {
  const ActivityOverviewScreen({super.key});
  static const routeName = "/overview-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Review Activies")),
        body: Consumer<Activities>(builder: (context, activities, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              var activity = activities.activitiesLog[index];
              return getCard(context, activity);
            },
            itemCount: activities.activitiesLog.length,
          );
        }));
  }

  Widget getCard(BuildContext context, ActivityLog e) {
    return ActivityCard(activtyLog: e);
  }
}

class ActivityCard extends StatefulWidget {
  const ActivityCard({
    Key? key,
    required this.activtyLog,
  }) : super(key: key);
  final ActivityLog activtyLog;

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EditActivityScreen.routeName,
            arguments: widget.activtyLog);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: widget.activtyLog.activity.color,
                radius: 5,
              ),
              SizedBox(width: 5),
              Text(widget.activtyLog.activity.name),
              VerticalDivider(
                thickness: 2,
              ),
              Text('${widget.activtyLog.length.inMinutes} minutes'),
            ],
          ),
        ),
      ),
    );
  }
}
