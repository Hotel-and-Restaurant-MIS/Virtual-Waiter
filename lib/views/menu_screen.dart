import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virtual_waiter/components/menu_item_tile.dart';
import 'package:virtual_waiter/constants/category_names.dart';
import 'package:virtual_waiter/controllers/data/menu_data_controller.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/data/settings_data_controller.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/menu_grid_builder.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/views/all_orders_screen.dart';
import '../constant.dart';
import '../constants/text_constants.dart';
import 'order_screen.dart';
import 'package:virtual_waiter/components/menu_shimmer.dart';

class MenuScreen extends StatelessWidget {
  // Initialize the MenuController
  OrderListDataController _oldc = OrderListDataController.instance;
  SettingsDataController _sdc = SettingsDataController.instance;
  MenuDataController _mdc = MenuDataController.instance;
  final MenuController menuController = Get.put(MenuController());

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
                        'Table #${_sdc.tableNo}',
                        style: TextConstants.kMainTextStyle(
                          fontFamily: 'Barlow',
                          fontWeight: FontWeight.w600,
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(height: 3.0),
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
                    (_oldc.orderList.length == 1 &&
                            _oldc.orderList.first.orderStatus ==
                                getOrderStatusFromString(
                                    OrderStatus.Editing.name))
                        ? Get.to(() => OrderScreen(editMode: true))
                        : Get.to(() => AllOrdersScreen());
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
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'My Orders',
                        style: TextStyle(
                          fontFamily: 'Barlow',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                  child: Text(category),
                ),
              );
            }).toList(),
          ),
        ),
        body: Obx(
          () {
            // Check if loading, show shimmer grid, otherwise show actual menu
            return _mdc.isGettingData.value
                ? MenuShimmerGrid() // Show shimmer
                : TabBarView(
                    children: kCategoryNameList.map<Widget>((category) {
                      return MenuGridBuilder.instance
                          .buildGridByCategory(category: category);
                    }).toList(),
                  );
          },
        ),
      ),
    );
  }
}
