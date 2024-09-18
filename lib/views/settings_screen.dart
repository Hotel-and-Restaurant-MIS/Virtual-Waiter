import 'package:flutter/material.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:virtual_waiter/controllers/data/settings_data_controller.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/views/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  SettingsDataController _sdc = SettingsDataController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 20.0, left: 30.0, right: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _sdc.setIsValidUser(false);
                        Get.offAll(() => WelcomeScreen());
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 35.0,
                      ),
                    ),
                    SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      'Settings',
                      style: TextConstants.kMainTextStyle(
                        fontSize: 28.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150.0,
              ),
              Obx(
                () => _sdc.isValidUser && !_sdc.firstTry
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Valid !',
                            style: TextConstants.kSubTextStyle(
                              textColour: Colors.lightGreen,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      )
                    : !_sdc.firstTry
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Incorrect Password !',
                                style: TextConstants.kSubTextStyle(
                                  textColour: Colors.redAccent,
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          )
                        : Text(''),
              ),
              SizedBox(
                height: 50.0,
              ),
              Obx(
                () => Visibility(
                  visible: !_sdc.isValidUser,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Password: ',
                            style: TextConstants.kSubTextStyle(fontSize: 25.0),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: SizedBox(
                              width: 250.0,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: TextField(
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Type here...',
                                    hintStyle: TextConstants.kSubTextStyle(
                                        fontSize: 17.0),
                                  ),
                                  controller: TextEditingController(),
                                  onChanged: (value) {
                                    _sdc.setPassword(value);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _sdc.checkPassword();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            width: 230.0,
                            margin: EdgeInsets.only(right: 20.0),
                            decoration: BoxDecoration(
                              color: kButtonClour.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'Check',
                                style: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Visibility(
                  visible: _sdc.isValidUser,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Select Table No :',
                            style: TextConstants.kSubTextStyle(fontSize: 25.0),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Obx(
                                () => Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: NumberPicker(
                                    itemCount: 5,
                                    selectedTextStyle: TextStyle(
                                        color: kButtonClour, fontSize: 28.0),
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 23.0),
                                    haptics: true,
                                    axis: Axis.horizontal,
                                    minValue: 1,
                                    maxValue: 20,
                                    itemHeight: 70.0,
                                    value: _sdc.tableNo,
                                    onChanged: (value) {
                                      _sdc.setTableNo(value);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(width: 100.0),
                        ],
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _sdc.loggedOutUser();
                            Get.to(() => WelcomeScreen());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60.0,
                            width: 230.0,
                            margin: EdgeInsets.only(right: 20.0),
                            decoration: BoxDecoration(
                              color: kButtonClour.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    fontFamily: 'Barlow',
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
