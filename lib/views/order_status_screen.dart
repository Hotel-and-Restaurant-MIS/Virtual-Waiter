import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(RunMyApp());
}

class RunMyApp extends StatelessWidget {
  const RunMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: Material(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/s1.svg',
            semanticsLabel: 'My SVG Image',
            height: 100,
            width: 70,
          ),
        ),
      ),
    );
  }
}


class OrderStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Material(
              child: Center(
                child: SvgPicture.asset(
                'images/Chef.svg',
                semanticsLabel: 'Chef',
                height: 420,
                width: 250,
                  ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Your Order Status',
              style: TextConstants.kMainTextStyle(),
            ),
            SizedBox(
              height: 50.0,
            ),

            //TODO: create order_status_controller with the webSocket.
            Container(
              height: 80.0,
              width: 200.0,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
