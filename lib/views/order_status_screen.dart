import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class OrderStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Image(
              width: 150.0,
              height: 150.0,
              image: AssetImage('images/chef.jpg'),
            ),
            Text('Your Order Status',style: TextConstants.kMainTextStyle(),),

          ],
        ),
      ),
    );
  }
}
