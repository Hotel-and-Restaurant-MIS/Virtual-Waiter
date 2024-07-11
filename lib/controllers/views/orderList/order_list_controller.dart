import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/model/OrderItem.dart';

import '../../../components/add_sub_button.dart';
import '../../../constants/text_constants.dart';

class OrderListController extends GetxController {
  static OrderListController instance = Get.find();

  OrderDataController _odc = OrderDataController.instance;

  RxList<OrderItem> _itemList = <OrderItem>[].obs;
  List<OrderItem> get itemList => _itemList;

  RxDouble _orderTotal = 1.0.obs;
  double get orderTotal => _orderTotal.value;
  set orderTotal(double value) {
    _orderTotal.value = value;
  }

  void _initController() {
    _itemList.value = [];
    _itemList = _odc.reactiveOrderList;
    calculateOrderTotal();
  }

  void refreshController() {
    _initController();

  }

  void removeItem({required String orderItemId}) {
    refresh();
    if (_odc.orderExists(orderItemId: orderItemId)) {
      print('removeItemId function is accessed.');
      itemList.removeWhere((order) => order.orderItemId == orderItemId);
      // _odc.removeItem(orderItemId : menuItemId);
    }
    calculateOrderTotal();
  }

  void calculateOrderTotal() {
    double total = 0.0;
    for (OrderItem orderItem in itemList) {
      total+=orderItem.totalPrice;
      print('orderTotal = ${orderItem.totalPrice}');

    }
    _orderTotal.value = total;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initController();
  }
}
