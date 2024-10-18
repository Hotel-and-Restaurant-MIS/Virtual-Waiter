import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/data/settings_data_controller.dart';
import 'package:virtual_waiter/controllers/views/all_orders_screen/all_orders_state_controller.dart';
import 'package:virtual_waiter/controllers/views/all_orders_screen/order_list_builder.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:virtual_waiter/views/settings_screen.dart';
import '../constant.dart';

class AllOrdersScreen extends StatelessWidget {
  OrderListDataController _oldc = OrderListDataController.instance;
  AllOrdersStateController _aosc = AllOrdersStateController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Obx(
          () => Visibility(
            visible: SettingsDataController.instance.isBillRequested,
            child: FloatingActionButton(
              backgroundColor: Colors.white38,
              onPressed: () {
                Get.to(() => SettingsScreen());
              },
              child: Center(
                child: Icon(
                  Icons.admin_panel_settings_rounded,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: kBackgroundClour.withOpacity(0.7),
      appBar: AppBar(
        leading: IconButton(
          iconSize: 35.0, // Increase the size here
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black38,
        shadowColor: Colors.grey,
        toolbarHeight: 100.0,
        title: Text(
          'My Orders',
          style: TextStyle(
            fontFamily: 'Barlow',
            fontSize: 28.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(
                () {
                  bool emptyList = OrderListBuilder.instance.children.isEmpty;
                  return !emptyList
                      ? Column(
                          children: OrderListBuilder.instance.children,
                        )
                      : Column();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40.0,
                  top: 50.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total price :',
                      style: TextConstants.kMainTextStyle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 35.0),
                      child: Text(
                        MoneyFormatter(amount: _oldc.calculateAllOrdersTotal())
                            .output
                            .nonSymbol,
                        style: TextConstants.kMainTextStyle(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              Obx(
                () => Visibility(
                  visible: !SettingsDataController.instance.isBillRequested,
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        bool allOrdersCompleted = _oldc.isAllOrdersCompleted();

                        if (allOrdersCompleted) {

                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2.0,
                              backgroundColor: kBackgroundClour,
                              title: Text(
                                'Generate Bill?',
                                style: TextConstants.kSubTextStyle(
                                  fontSize: 26.0,
                                ),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Order items in the cart will not be added to \nthe bill. Do you want to generate the bill?',
                                    style: TextConstants.kSubTextStyle(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back(); // Close the dialog
                                        },
                                        child: Text(
                                          'No',
                                          style: TextStyle(fontSize: 17.0),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await _aosc
                                              .generateBill(); // Call your generateBill function
                                          Get.back(); // Close the dialog
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(fontSize: 17.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          // Show the Get.defaultDialog if not all orders are completed
                          Get.defaultDialog(
                            title: 'Cannot Generate Bill',
                            content: Text(
                              'Some orders are still being prepared or pending. Please wait until all orders are\n completed before generating the bill.',
                            ),
                            confirm: ElevatedButton(
                              onPressed: () {
                                Get.back(); // Close the dialog
                              },
                              child: Text('OK'),
                            ),
                          );
                        }
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
                            'Generate Bill',
                            style: TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
