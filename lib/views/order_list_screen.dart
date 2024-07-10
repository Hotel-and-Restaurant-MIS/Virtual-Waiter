import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/add_sub_button.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/controllers/views/orderList/order_list_controller.dart';
import 'package:virtual_waiter/controllers/views/orderList/view_order_quantity_controller.dart';
import 'package:virtual_waiter/model/OrderItem.dart';
import 'package:virtual_waiter/views/single_menu_item_screen.dart';

import '../controllers/data/order_data_controller.dart';
import '../controllers/views/single_menu_item_screen/smis_state_controller.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderDataController _orderDataController = OrderDataController.instance;

    //Data refresh function
    late OrderListController _orderListController;

    return Scaffold(
      backgroundColor: kBackgroundClour.withOpacity(0.7),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            double deviceWidth = MediaQuery.of(context).size.width;
            double deviceHeight = MediaQuery.of(context).size.height;
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      SizedBox(
                        width: orientation == Orientation.portrait
                            ? deviceWidth * 0.35
                            : deviceWidth * 0.4,
                      ),
                      Text(
                        'My Orders',
                        style: TextStyle(
                          fontFamily: 'Barlow',
                          fontSize: 28.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: deviceWidth * 0.25),
                      Text(
                        'Item',
                        style: TextConstants.kSubTextStyle(fontSize: 23.0),
                      ),
                      SizedBox(width: deviceWidth * 0.2),
                      Text(
                        'Qty',
                        style: TextConstants.kSubTextStyle(
                          fontSize: 23.0,
                        ),
                      ),
                      SizedBox(
                        width: orientation == Orientation.portrait
                            ? deviceWidth * 0.1
                            : deviceWidth * 0.2,
                      ),
                      Center(
                        child: Text(
                          'Price\nLKR',
                          style: TextConstants.kSubTextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1.0,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  ),
                  Obx(
                    () => Column(
                      children: _orderDataController.reactiveOrderList
                          .map<Widget>((orderItem) {
                        String quantityContTag =
                            'order-item-${orderItem.menuItemId}-quantity';
                        Get.put(VoqController(quantity: orderItem.quantity),
                            tag: quantityContTag);
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 25.0,
                            right: 15.0,
                            top: 30.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 400.0,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              orderItem.imageURL),
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          orderItem.itemName,
                                          style: TextConstants.kSmallTextStyle(
                                              fontSize: 23.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          'LKR ${orderItem.unitPrice.toStringAsFixed(2)}',
                                          style: TextConstants.kSmallTextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 19.0,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 40.0,
                                child: Text(
                                  orderItem.quantity.toString(),
                                  style: TextConstants.kSmallTextStyle(
                                      fontSize: 25.0),
                                ),
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              Container(
                                width: 130.0,
                                child: Text(
                                  '${orderItem.totalPrice.toStringAsFixed(2)}',
                                  style: TextConstants.kSmallTextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              GestureDetector(
                                onTap: (){
                                  Get.to(() =>SingleMenuItemScreen(menuItem: orderItem.menuItem));
                                  _orderDataController.removeItem(itemId: orderItem.menuItemId);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.lightGreen),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  width: 40.0,
                                  height: 40.0,
                                  child: Center(child: Icon(Icons.edit)),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              GestureDetector(
                                onTap: () => _orderDataController.removeItem(
                                    itemId: orderItem.menuItemId),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: kButtonClour),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  width: 40.0,
                                  height: 40.0,
                                  child:
                                      Center(child: Icon(Icons.delete_outline)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
