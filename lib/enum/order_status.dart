import 'package:get/get.dart';

enum OrderStatus{
  Pending,Preparing,Completed,Editing,Paid
}

Rx<OrderStatus> getOrderStatusFromString(String status) {
  switch (status) {
    case 'Pending':
      return Rx<OrderStatus>(OrderStatus.Pending);
    case 'Preparing':
      return Rx<OrderStatus>(OrderStatus.Preparing);
    case 'Completed':
      return Rx<OrderStatus>(OrderStatus.Completed);
    case 'Editing':
      return Rx<OrderStatus>(OrderStatus.Editing);
    default:
      throw Exception('Invalid order status: $status');
  }
}