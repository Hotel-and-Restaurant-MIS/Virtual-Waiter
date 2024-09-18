import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/order_tile.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/views/order_screen.dart';

import '../../../model/order.dart';

class OrderListBuilder extends GetxController {
  static OrderListBuilder instance = Get.find();
  OrderListDataController _oldc = OrderListDataController.instance;

  List<Order> _orderList = [];
  RxList<Widget> _children = <Widget>[].obs;
  List<Widget> get children => _children;

  void buildOrderList() {
    _children.value = [];
    if (_orderList.isEmpty) {
      _children.add(
        const Center(
          child: Text(
            'No Order ar placed',
          ),
        ),
      );
      return;
    }
    for (Order order in _orderList) {
      _children.add(GestureDetector(
        onTap: () => Get.to(() {
          if (order.orderStatus == OrderStatus.Editing) {
            return OrderScreen(
              editMode: true,
            );
          } else {
            return OrderScreen(
              orderItemList: order.orderItemList,
            );
          }
        }),
        child: OrderTile(
            orderId: order.orderId.toString(),
            orderStatus: order.orderStatus,
            orderTotal: order.orderTotal),
      ));
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    buildOrderList();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_oldc.reactiveOrderList, (list) {
      _orderList = list;
      buildOrderList();
    });
  }
}
