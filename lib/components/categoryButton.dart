import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/constant.dart';

class CategoryButton extends StatelessWidget {
  late String categoryName;
  bool isCategorySelect = false;
   final int categoryNo;
  final Function() onPressed;

  CategoryButton(
      {required this.categoryName,
      required this.onPressed,
      required this.isCategorySelect,
      required this.categoryNo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: IntrinsicWidth(
        child: Container(
          height: 33.0,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontFamily: 'Barlow'),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4.0),
                height: 2.0,
                // width: 120.0,
                decoration: BoxDecoration(
                  color: isCategorySelect
                      ? kButtonClour
                      : Colors.white.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
