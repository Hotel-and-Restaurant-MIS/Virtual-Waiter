import 'package:get/get.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/exception/editable_order_not_exists_exception.dart';
import 'package:virtual_waiter/exception/multiple_editable_orders_exist_exception.dart';
import 'package:virtual_waiter/model/order.dart';

class OrderListDataController extends GetxController {
  static OrderListDataController instance = Get.find();

  RxList<Order> _orderList = <Order>[].obs;

  List<Order> get orderList => _orderList.value;

  void setOrderList(List<Order> value) {
    _orderList.value = value;
  }

  void addOrder(Order order) {
    _orderList.add(order);
  }

  bool editableOrderExists()
  {
    return _orderList.any((order) => order.orderStatus == OrderStatus.Editing);
  }

  Order getEditableOrder() {
    List<Order> possibleEditableOrders = _orderList.where((order) => order.orderStatus == OrderStatus.Editing).toList();
    if(possibleEditableOrders.isEmpty)
      {
        //throw error
        throw EditableOrderNotExistsException();
      }
    else if(possibleEditableOrders.length > 1)
      {
        //throw error
        throw MultipleEditableOrdersExistException();
      }
    else
      {
        return possibleEditableOrders.first;
      }
  }
}
