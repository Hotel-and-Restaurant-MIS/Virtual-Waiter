import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/model/OrderItem.dart';

class Order {
  final List<OrderItem> orderItemList;
  final OrderStatus orderStatus;
  final double orderTotal;
  final String orderId;
  final int tableId;

  Order({required this.orderId,required this.orderItemList, required this.orderStatus,required this.orderTotal,required this.tableId});

  set orderItemList(value) => orderItemList = value;
}
