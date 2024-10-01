import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/alert_dialog_box.dart';
import 'package:virtual_waiter/components/dialog_box.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/views/menu_screen.dart';
import 'package:virtual_waiter/views/menu_screen.dart';
import 'package:virtual_waiter/views/settings_screen.dart';
import '../controllers/views/welcomeScreen/welcome_screen_controller.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    print(orientation);
    return Scaffold(
      backgroundColor: kBackgroundClour.withOpacity(0.4),
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
                        messege: 'Human waiter will come to your table soon!');
                  },
                );
                print('help is coming');
              } catch (e) {
                Navigator.pop(
                    context); // Close the AlertDialog before showing DialogBox
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogBox(messege: 'An Un Expected error occurs ');
                  },
                );
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
            color: kButtonClour,
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 70.0,
          height: 50.0,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Get.to(()=>SettingsScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0,top: 20.0),
                    child: Icon(
                      Icons.settings_outlined,
                      size: 40.0,
                      weight: 1.0,
                    ),
                  )),
              SizedBox(
                height: 80,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 200.0, left: 60),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          'I am your \n   Virtual Waiter',
                          textStyle: TextConstants.kMainTextStyle(
                            textColour: Colors.white,
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
              Center(
                child: Container(
                  width: 250.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: kButtonClour,
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3.0,
                        blurRadius: 5.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => MenuScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Proceed to Order',
                          style: TextConstants.kSubTextStyle(
                              fontSize: 20, textColour: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
