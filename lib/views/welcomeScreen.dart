import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 200.0, left: 60),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          'I am your \n   virtual waiter',
                          textStyle: TextConstants.kMainTextStyle(
                            textColour: Colors.black,
                            fontSize: 45.0,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      repeatForever: false,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Image(
                      image: AssetImage('images/waiter2.png'),
                      height: 450,
                      width: 350,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 130,
              ),
              Container(
                width: 250.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(50.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 5.0,
                      blurRadius: 7.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Proceed to Order',
                      style: TextConstants.kSubTextStyle(
                          fontSize: 20, textColour: Colors.black),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
