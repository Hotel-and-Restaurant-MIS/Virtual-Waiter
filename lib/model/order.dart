import 'dart:ffi';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/model/order_item.dart';

class Order {
  final List<OrderItem> orderItemList;
   Rx<OrderStatus> orderStatus;
  final double orderTotal;
  int? orderId;
  final int tableId;
  DateTime? dateTime;

  Order(
      {this.orderId,
      this.dateTime,
      required this.orderItemList,
      required this.orderStatus,
      required this.orderTotal,
      required this.tableId});

  set orderItemList(value) => orderItemList = value;

  // Factory constructor to create an instance of Order from a map
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
        dateTime: DateTime.parse(map['dateTime']),
        orderId: map['orderId'],
        orderItemList: List<OrderItem>.from(
            map['orderItems'].map((item) => OrderItem.fromMap(item))),
        orderStatus: getOrderStatusFromString(map['status']['statusName']),
        orderTotal: map['totalPrice'],
        tableId: map['tableId']);
  }

// Method to convert an instance of Order to a map
  Map<String, dynamic> toMap() {
    return {
      'orderItemList': orderItemList.map((item) => item.toMap()).toList(),
      'orderTotal': orderTotal.toString(),
      'tableId': tableId.toString()
    };
  }

  Map<String, dynamic> toMapWS() {
    return {
      'orderId': orderId,
      'tableId': tableId,
      'dateTime': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime!),  // Adjusted to match your format
      'totalPrice': orderTotal,
      'status': {
                'statusName': orderStatus.value.name
      },
      'orderItems': orderItemList.map((item) => item.toMapWS()).toList(),
    };
  }

}
