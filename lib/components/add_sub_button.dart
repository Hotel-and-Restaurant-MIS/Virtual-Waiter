import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../constants/text_constants.dart';

class AddSubButton extends StatelessWidget {
  int value;
  Function() onAddPress;
  Function() onSubPress;

  AddSubButton(
      {required this.value,
      required this.onAddPress,
      required this.onSubPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onSubPress,
          child: Container(
            height: 40.0,
            width: 40.0,
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 35.0,
              weight: 10.0,
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        ),
        Container(
          height: 50.0,
          width: 50.0,
          child: Center(
              child: Text(
            '$value',
            style: TextConstants.kSubTextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.w700,
              textColour: kButtonClour,
            ),
          )),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xFF2D303E).withOpacity(0.6),
              border: Border.all(
                  color: Color(0xFF393C49).withOpacity(0.9), width: 2.0)),
        ),
        SizedBox(
          width: 15.0,
        ),
        GestureDetector(
          onTap: onAddPress,
          child: Container(
            height: 40.0,
            width: 40.0,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 35.0,
              weight: 10.0,
            ),
          ),
        ),
      ],
    );
  }
}
