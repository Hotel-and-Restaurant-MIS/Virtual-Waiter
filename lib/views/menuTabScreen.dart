import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/categoryButton.dart';
import 'package:virtual_waiter/constants/textConstants.dart';
import 'package:intl/intl.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/views/orderList.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/menuTabController.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/menuTabController.dart';


class MenuTabScreen extends StatelessWidget {
  final String tableNumber = '01';

  @override
  Widget build(BuildContext context) {
    String formattedDate =
    DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    final MenuTabController menuTabController = Get.find();
    return Scaffold(
      appBar: AppBar(

        title: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                   margin: EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Table #${tableNumber}',
                              style: TextConstants.kMainTextStyle(
                                fontFamily: 'Barlow',
                                fontWeight: FontWeight.w600,
                                fontSize: 28.0,
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Text(
                              formattedDate,
                              style: TextConstants.kSubTextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                textColour: Color(0xFFE0E6E9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => OrderList());
                        },
                        child: Container(
                          height: 37.0,
                          width: 140.0,
                          margin: EdgeInsets.only(right: 20.0),
                          decoration: BoxDecoration(
                              color: kButtonClour,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 15.35),
                                    blurRadius: 30.06,
                                    color: kButtonClour.withOpacity(0.4))
                              ]),
                          child: Center(
                            child: Text(
                              'My Orders',
                              style: TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 35.0,),
              ],
            ),
          ),
        ),
          bottom:TabBar(
            //padding: EdgeInsets.only(top: 10.0),
            controller: menuTabController.tabController, // TODO: use the menuTabController here.
          indicatorColor: Colors.orange,
          indicatorWeight: 4.0,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.orange,
          tabs: [
            Tab(text: 'Hot Dishes'),
            Tab(text: 'Cold Dishes'),
            Tab(text: 'Soup'),
            Tab(text: 'Grill'),
            Tab(text: 'Appetizer'),
            Tab(text: 'Dessert'),
          ],
          )
      ),
      backgroundColor: kBackgroundClour,

    );
  }
}
