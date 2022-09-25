// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:time_tracker_app/models/activities.dart';
import 'package:time_tracker_app/widgets/popups/color_picker_popup.dart';

class ActivityCreateScreen extends StatefulWidget {
  const ActivityCreateScreen({super.key});
  static const routeName = "/create-screen";

  @override
  State<ActivityCreateScreen> createState() => _ActivityCreateScreenState();
}

class _ActivityCreateScreenState extends State<ActivityCreateScreen> {
  final _form = GlobalKey<FormState>();
  var _createNew = true;
  var _activityColor = Colors.red.value;
  var _selectedActivity = "new";
  String? _activityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Start an Activity")),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              ActivitySelector(
                onSelected: onSelected,
              ),
              SizedBox(
                height: 10,
              ),
              if (_createNew)
                ActivityCreator(
                  activityColor: _activityColor,
                  onSaved: setActivityName,
                  pickColor: _pickColor,
                ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Start Activity"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSelected(String? value) {
    setState(() {
      _createNew = value == "new";
      _selectedActivity = value!;
    });
  }

  void _submitForm() {
    if (!_createNew) {
      Navigator.pop(context, _selectedActivity);
      return;
    }
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    Activities.addActivity(_activityName!, _activityColor);
    Navigator.pop(context, _activityName);
  }

  void _pickColor() async {
    var color = await showDialog<int>(
      context: context,
      builder: (context) => ColorPickerPopup(),
    );
    setState(() {
      _activityColor = color ?? _activityColor;
    });
  }

  void setActivityName(String? value) {
    _activityName = value;
  }
}

class ActivitySelector extends StatelessWidget {
  final Function(String?) onSelected;

  const ActivitySelector({
    Key? key,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        border: OutlineInputBorder(),
      ),
      value: "new",
      items: Activities.activities
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e.name,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: e.color,
                      ),
                      SizedBox(width: 5),
                      Text(e.name),
                    ],
                  ),
                ),
              )
              .toList() +
          [
            /*DropdownMenuItem<String>(
          value: "YouTube",
          child: Row(
            children: [
              CircleAvatar(
                radius: 5,
                backgroundColor: Colors.red,
              ),
              SizedBox(width: 5),
              Text("YouTube"),
            ],
          ),
        ),*/
            DropdownMenuItem<String>(
              value: "new",
              child: Text("Create New Activity"),
              enabled: true,
            ),
          ],
      onChanged: onSelected,
    );
  }
}

class ActivityCreator extends StatelessWidget {
  const ActivityCreator({
    Key? key,
    required int activityColor,
    required this.pickColor,
    required this.onSaved,
  })  : _activityColor = activityColor,
        super(key: key);

  final int _activityColor;
  final VoidCallback pickColor;
  final Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: OutlinedButton(
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Color(_activityColor),
            ),
            onPressed: pickColor,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              border: OutlineInputBorder(),
              hintText: "Activity Name",
            ),
            validator: (value) {
              if (value == null || value == "") {
                return "Enter a value";
              }
              return null;
            },
            onSaved: onSaved,
          ),
        ),
      ],
    );
  }
}
