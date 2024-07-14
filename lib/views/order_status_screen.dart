import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class OrderStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('images/Chef.svg',width: 400.0,height: 400.0,),
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
      ),
    );
  }
}
