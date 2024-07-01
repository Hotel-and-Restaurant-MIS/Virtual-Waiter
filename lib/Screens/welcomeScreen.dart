import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
          child: Column(
        children: <Widget>[
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 200.0, left: 20),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'I am your \n   virtual waiter',
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'Saira',
                        fontStyle: FontStyle.italic,
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  repeatForever: false,
                ),
              ),
              Image(
                image: AssetImage('images/waiter2.png'),
                height: 500,
                width: 400,
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
