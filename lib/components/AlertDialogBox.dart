import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogBox extends StatelessWidget {
  final String alertDialogTitle;
  final String alertDialogDiscription;

  AlertDialogBox({
    required this.alertDialogTitle,
    required this.alertDialogDiscription,
  });

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertDialogTitle),
      content: Text(alertDialogDiscription),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
