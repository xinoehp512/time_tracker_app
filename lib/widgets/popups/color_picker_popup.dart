import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:time_tracker_app/models/colors.dart';

class ColorPickerPopup extends StatelessWidget {
  const ColorPickerPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Activity Color"),
      content: Container(
        padding: EdgeInsets.all(10),
        width: 200,
        height: 250,
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: 16,
            itemBuilder: (context, index) => OutlinedButton(
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: ColorsList.colors[index],
                  ),
                  onPressed: () =>
                      Navigator.pop(context, ColorsList.colors[index].value),
                )),
        //onPressed: () => Navigator.pop(context, 0),
      ),
    );
  }
}
