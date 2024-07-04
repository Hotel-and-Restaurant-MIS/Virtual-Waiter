import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  final String alertDialogTitle;
  final String alertDialogDiscription;
  // final Color backgroundColour;
  final VoidCallback? onOKPresses;

  AlertDialogBox({
    required this.alertDialogTitle,
    required this.alertDialogDiscription,
    // required this.backgroundColour,
    this.onOKPresses,
  });

  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Colors.white, // Set the border color here
          width: 2.0,
        ),
      ),
      // contentTextStyle: TextStyle(color: Colors.black),
      // backgroundColor: backgroundColour,
      title: Text(alertDialogTitle),
      content: Text(alertDialogDiscription),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (onOKPresses != null) {
              onOKPresses!();
            } else {
              Navigator.pop(context, 'OK');
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
