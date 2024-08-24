import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/views/order_screen/order_state_controller.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/extensions.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/model/order.dart';

class OrderDataController extends GetxController {
  static OrderDataController instance = Get.find();

  OrderListDataController _oldc = OrderListDataController.instance;
  // OrderStateController _osc = OrderStateController.instance;
  List<OrderItem> _orderItemList = [];

  RxList<OrderItem> reactiveOrderItemList = <OrderItem>[]
      .obs; //this duplicate order List is create for change the quantity at the orderList

  List<OrderItem> get orderItemList => _orderItemList;

  void addOrderItem({required OrderItem orderItem}) {
    _orderItemList.add(orderItem);
    reactiveOrderItemList.add(orderItem);
  }

  bool orderItemExists({required String orderItemId}) {
    return _orderItemList.any((order) => order.orderItemId == orderItemId);
  }
}
