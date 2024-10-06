import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class DialogBox extends StatelessWidget {
  final String messege;

  DialogBox({required this.messege});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Colors.white, // Set the border color here
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(messege,style: TextConstants.kSmallTextStyle(fontSize: 18.0),),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Close',style: TextStyle(color: kButtonClour,fontSize: 18.0),),
          ),
        ],
      ),
    );
  }
}
