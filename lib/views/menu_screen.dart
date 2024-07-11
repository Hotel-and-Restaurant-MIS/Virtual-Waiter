import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virtual_waiter/components/menu_item_tile.dart';
import 'package:virtual_waiter/constants/category_names.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/menu_grid_builder.dart';

import '../constant.dart';
import '../constants/text_constants.dart';
import 'order_list_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  final String tableNumber = '01';
  @override
  Widget build(BuildContext context) {
    String formattedDate =
    DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: kBackgroundClour.withOpacity(0.3),
        appBar: AppBar(
          toolbarHeight: 100.0,
          title: Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 3.0),
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
                              color: kButtonClour.withOpacity(0.3))
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
            ),//end
          ),
          bottom: TabBar(
            labelColor: kButtonClour,
            dividerHeight: 2.0,
            indicatorWeight: 3.0,
            indicatorColor: kButtonClour,
            isScrollable: true,
            tabs: kCategoryNameList.map<Widget>((category) {
              return Tab(

                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50,
                  child: Text(
                    category,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: kCategoryNameList
              .map<Widget>(
                (category) => MenuGridBuilder.instance.buildGridByCategory(category: category),
              )
              .toList(),
        ),
      ),
    );
  }
}
