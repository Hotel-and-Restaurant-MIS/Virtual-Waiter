import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/add_sub_button.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/model/OrderItem.dart';

import '../controllers/data/order_data_controller.dart';
import '../controllers/views/single_menu_item_screen/smis_state_controller.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SmisStateController _smisStateController = SmisStateController.instance;
    OrderDataController _orderDataController = OrderDataController.instance;
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
                      SizedBox(width: deviceWidth * 0.3),
                      Text(
                        'Item',
                        style: TextConstants.kSubTextStyle(fontSize: 20.0),
                      ),
                      SizedBox(width: deviceWidth * 0.3),
                      Text(
                        'Qty',
                        style: TextConstants.kSubTextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: orientation == Orientation.portrait
                            ? deviceWidth * 0.15
                            : deviceWidth * 0.2,
                      ),
                      Center(
                          child: Text(
                        'Price\nLKR',
                        style: TextConstants.kSubTextStyle(
                          fontSize: 20.0,
                        ),
                      )),
                    ],
                  ),
                  Container(
                    height: 1.0,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.5)),
                  ),
                  Column(
                    children:
                        _orderDataController.orderList.map<Widget>((orderItem) {
                      return Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage: CachedNetworkImageProvider(
                                    orderItem.imageURL),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    orderItem.itemName,
                                    style: TextConstants.kSmallTextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    orderItem.unitPrice.toStringAsFixed(2),
                                    style: TextConstants.kSmallTextStyle(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Obx(
                            () => AddSubButton(
                              value: _orderDataController.reactiveOrderList
                                  .where((order) =>
                                      order.menuItemId == orderItem.menuItemId)
                                  .toList()
                                  .first
                                  .quantity,
                              onAddPress: () {
                                _orderDataController.incrementQuantity(
                                    itemId: orderItem.menuItemId);
                              },
                              onSubPress: () {
                                _orderDataController.decrementQuantity(
                                    itemId: orderItem.menuItemId);
                              },
                            ),
                          ),
                          Text(
                            orderItem.totalPrice.toStringAsFixed(2),
                            style: TextConstants.kSmallTextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.w500),
                          )
                        ],
                      );
                    }).toList(),
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
