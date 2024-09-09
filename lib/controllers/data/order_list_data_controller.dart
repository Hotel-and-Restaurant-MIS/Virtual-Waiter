import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/exception/editable_order_not_exists_exception.dart';
import 'package:virtual_waiter/exception/multiple_editable_orders_exist_exception.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/model/order.dart';

class OrderListDataController extends GetxController {
  static OrderListDataController instance = Get.find();

  RxList<Order> _orderList = <Order>[].obs;

  List<Order> get orderList => _orderList;
  RxList<Order> get reactiveOrderList => _orderList;


  void setOrderList(List<Order> value) {
    _orderList.value = value;
  }

  void addOrder(Order order) {
    _orderList.add(order);
    print('new order is added length is: ${_orderList.length}');
  }

  void removeEditableOrder() {
    _orderList.removeWhere((order) => order.orderStatus == OrderStatus.Editing);
  }

  bool editableOrderExists() {
    return _orderList.any((order) => order.orderStatus == OrderStatus.Editing);
  }

  Order getEditableOrder() {
    List<Order> possibleEditableOrders = _orderList
        .where((order) => order.orderStatus == OrderStatus.Editing)
        .toList();
    if (possibleEditableOrders.isEmpty) {
      //throw error
      throw EditableOrderNotExistsException();
    } else if (possibleEditableOrders.length > 1) {
      //throw error
      throw MultipleEditableOrdersExistException();
    } else {
      return possibleEditableOrders.first;
    }
  }

  void updateEditableOrder(
      {List<OrderItem>? orderItemList,
      OrderStatus? orderStatus,
      double? orderTotal,
      int? tableId,
      Long? orderId}) {
    Order editable = getEditableOrder();
    removeEditableOrder();
    _orderList.add(
      Order(
        orderId: orderId ?? editable.orderId,
        tableId: tableId ?? editable.tableId,
        orderItemList: orderItemList ?? editable.orderItemList,
        orderTotal: orderTotal ?? editable.orderTotal,
        orderStatus: orderStatus ?? editable.orderStatus,
      ),
    );
  }
  double calculateAllOrdersTotal(){
    List<Order> allNonEditableOrders = _orderList.where((order)=>order.orderStatus != OrderStatus.Editing).toList();
    double allOrdersPrice = 0;
    for (var order in allNonEditableOrders) {
        allOrdersPrice+= order.orderTotal;
    }
    return allOrdersPrice;
  }
}
