import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/orderTile.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';

class OrderListBuilder extends GetxController {
  static OrderListBuilder instance = Get.find();
  OrderListDataController _oldc = OrderListDataController.instance;

  List<Widget> buildOrderList() {
    List orderList = _oldc.orderList;
    List<Widget> children = [];

    if (orderList.isEmpty) {
      return [Center(child: Text('No Order ar placed'))];
    }
    orderList.forEach((order) {

      children.add(OrderTile(
          orderNo: order.orderId,
          orderStatus: order.orderStatus,
          orderTotal: order.orderTotal));
    });

    return children;
    // return CustomScrollView(
    //   slivers: <Widget>[
    //     SliverPadding(
    //         padding: const EdgeInsets.only(bottom: 30),
    //         sliver: SliverList.list(children: children))
    //   ],
    // );
  }
}
