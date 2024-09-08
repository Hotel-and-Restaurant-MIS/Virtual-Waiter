import 'dart:ffi';

import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/model/order_item.dart';

class Order {
  final List<OrderItem> orderItemList;
  final OrderStatus orderStatus;
  final double orderTotal;
  Long? orderId;
  final int tableId;

  Order(
      {this.orderId,
      required this.orderItemList,
      required this.orderStatus,
      required this.orderTotal,
      required this.tableId});

  set orderItemList(value) => orderItemList = value;

  // Factory constructor to create an instance of Order from a map
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        orderId: map['orderId'],
        orderItemList: map['orderItemList'],
        orderStatus: map['orderStatus'],
        orderTotal: map['orderTotal'],
        tableId: map['tableId']);
  }
// Method to convert an instance of Order to a map
  Map<String,dynamic> toMap(){
    return{
      'orderId':orderId,
      'orderItemList':orderItemList,
      'orderStatus':orderStatus,
      'orderTotal':orderTotal,
      'tableId':tableId
    };
  }
}
