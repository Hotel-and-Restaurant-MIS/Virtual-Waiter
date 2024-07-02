import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:virtual_waiter/components/alert_dialog_box.dart';
import 'package:virtual_waiter/components/dialog_box.dart';
import 'package:virtual_waiter/constants/text_constants.dart';

import '../controllers/views/welcome_screen_controller.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialogBox(
            alertDialogTitle: 'Need Help ?',
            alertDialogDiscription:
                'We can provide you help from \nhuman waiter',
            onOKPresses: () async {
              try {
                await WelcomeScreenController.instance.tapBtnToRequestHelp();
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogBox(
                        massege: 'Human waiter will come to your table soon!');
                  },
                );
                print('help is coming');
              } catch (e) {
                Navigator.pop(
                    context); // Close the AlertDialog before showing DialogBox
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogBox(massege: 'An Un Expected error occurs ');
                  },
                );
                // DialogBox(massege: 'An unexpected error occurs');
              }
            },
          ),
        ),
        child: Container(
          child: Center(
              child: Text(
            'Help',
            style: TextConstants.kSubTextStyle(
                fontSize: 20.0, textColour: Colors.white),
          )),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(15.0),
          ),
          width: 70.0,
          height: 70.0,
        ),
      ),
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
