import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/model/order.dart';

import '../../../components/add_sub_button.dart';
import '../../../constants/text_constants.dart';
import '../../network/web_socket_controller.dart';

class OrderStateController extends GetxController {
  static OrderStateController instance = Get.find();
  int tableNo = 005;

  int orderNo =0;

  OrderDataController _odc = OrderDataController.instance;
  OrderListDataController _oldc = OrderListDataController.instance;

  RxList<OrderItem> _itemList = <OrderItem>[].obs;
  List<OrderItem> get itemList => _itemList;

  RxDouble _orderTotal = 1.0.obs;
  double get orderTotal => _orderTotal.value;
  set orderTotal(double value) {
    _orderTotal.value = value;
  }

  void _initController() {
    _itemList.value = [];
    _itemList = _odc.reactiveOrderItemList;
    calculateOrderTotal();
  }

  void refreshController() {
    _initController();
  }

  void removeItem({required String orderItemId}) {
    refresh();
    if (_odc.orderItemExists(orderItemId: orderItemId)) {
      print('removeItemId function is accessed.');
      itemList.removeWhere((order) => order.orderItemId == orderItemId);
      // _odc.removeItem(orderItemId : menuItemId);
    }
    calculateOrderTotal();
  }

  void calculateOrderTotal() {
    double total = 0.0;
    for (OrderItem orderItem in itemList) {
      total += orderItem.totalPrice;
      print('orderTotal = ${orderItem.totalPrice}');
    }
    _orderTotal.value = total;
  }

  Future<void> sendOrderList() async {
    try {
      orderNo++;
      WebSocketController webSC = WebSocketController.instance;
      _oldc.addOrder(Order(
          orderItemList: _itemList,
          orderStatus: OrderStatus.Pending,
          orderTotal: _orderTotal.value, orderId: '$orderNo',tableId: tableNo));
      await webSC.sendOrderList(Order(
          tableId: tableNo,
          orderId: '$tableNo/_$orderNo',
          orderItemList: _itemList,
          orderStatus: OrderStatus.Pending,
          orderTotal: _orderTotal.value));
    } catch (e) {
      print("error occurs send Order item List to Order Manager");
      rethrow;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initController();
  }
}
