import 'package:flutter/material.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:virtual_waiter/controllers/data/table_no_controller.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/views/welcome_screen.dart';

class SettingsScreen extends StatelessWidget {
  // late int _currentTableNo = 1;

  TableNoController _tnc = TableNoController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
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
              Padding(
                padding: const EdgeInsets.only(right: 50.0, left: 20.0),
                child: Row(
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
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
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
                              value: _tnc.tableNo,
                              onChanged: (value) {
                                _tnc.setTableNo(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 100.0),
                  ],
                ),
              ),
              SizedBox(height: 100.0,),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=>WelcomeScreen());
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
    );
  }
}
