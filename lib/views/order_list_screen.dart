import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/add_sub_button.dart';
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/constants/text_constants.dart';
import 'package:virtual_waiter/model/OrderItem.dart';
import 'package:virtual_waiter/views/single_menu_item_screen.dart';

import '../controllers/data/order_data_controller.dart';
import '../controllers/views/orderListScreen/order_list_controller.dart';
import '../controllers/views/orderListScreen/view_order_quantity_controller.dart';
import '../controllers/views/single_menu_item_screen/smis_state_controller.dart';
import 'order_status_screen.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderDataController _orderDataController = OrderDataController.instance;
    OrderListController _orderListController = OrderListController.instance;

    //Data refresh function
    // late OrderListController _orderListController;

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _orderDataController.reactiveOrderList
                          .map<Widget>((orderItem) {
                        String quantityContTag =
                            'order-item-${orderItem.menuItem.id}-quantity';
                        Get.put(VoqController(quantity: orderItem.quantity),
                            tag: quantityContTag);

                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 10.0,
                            top: 30.0,
                          ),
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: kBackgroundClour.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 400.0,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CircleAvatar(
                                        radius: 35.0,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                orderItem.menuItem.imageUrl),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            orderItem.menuItem.name,
                                            style:
                                                TextConstants.kSmallTextStyle(
                                                    fontSize: 23.0,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                          Text(
                                            'LKR ${orderItem.menuItem.price.toStringAsFixed(2)}',
                                            style:
                                                TextConstants.kSmallTextStyle(
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
                                  onTap: () {
                                    Get.to(() => SingleMenuItemScreen(
                                        menuItem: orderItem.menuItem));
                                    _orderListController.removeItem(
                                        orderItemId: orderItem.orderItemId);
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
                                  // onTap: () => _orderDataController.removeItem(
                                  //     orderItemId: orderItem.orderItemId),
                                  onTap: () => _orderListController.removeItem(
                                      orderItemId: orderItem.orderItemId),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kButtonClour),
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    width: 40.0,
                                    height: 40.0,
                                    child: Center(
                                        child: Icon(Icons.delete_outline)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: deviceHeight*0.08,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: orientation == Orientation.portrait
                            ? deviceWidth * 0.07
                            : deviceWidth * 0.08,
                      ),
                      Text(
                        'Order total :',
                        style: TextConstants.kSubTextStyle(
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(
                          width: orientation == Orientation.portrait
                              ? deviceWidth * 0.4
                              : deviceWidth * 0.65),
                      Obx(
                        () => Text('LKR  '+
                           _orderListController.orderTotal.toStringAsFixed(2),
                          style: TextConstants.kSubTextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 50.0),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => OrderStatusScreen());
                    },
                    child: Container(
                      height: deviceHeight*0.05,
                      width: deviceWidth*0.8,
                      margin: EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                          color: kButtonClour,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 15.35),
                                blurRadius: 30.06,
                                color: kButtonClour.withOpacity(0.3))
                          ]),
                      child: Center(
                        child: Text(
                          'Order',
                          style: TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight*0.1,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
