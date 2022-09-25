import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelector extends StatefulWidget {
  DateTime date;
  Function({DateTime? date, TimeOfDay? time}) setDate;

  DateTimeSelector(this.date, this.setDate);

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  final dateFormat = DateFormat("MMMM dd, y");
  final timeFormat = DateFormat("h:mm a");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        TextButton(
            onPressed: () async {
              var newDate = await showDatePicker(
                  context: context,
                  initialDate: widget.date,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now());
              if (newDate == null) {
                return;
              }
              setState(() {
                widget.setDate(date: newDate);
              });
            },
            child: Text(dateFormat.format(widget.date))),
        SizedBox(width: 10),
        TextButton(
            onPressed: () async {
              var newTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(widget.date));
              if (newTime == null) {
                return;
              }
              setState(() {
                widget.setDate(time: newTime);
              });
            },
            child: Text(timeFormat.format(widget.date))),
      ]),
    );
  }
}
