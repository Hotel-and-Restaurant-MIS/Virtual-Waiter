import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/data/settings_data_controller.dart';
import 'package:virtual_waiter/controllers/network/order_network_controller.dart';
import 'package:virtual_waiter/controllers/network/web_socket_controller.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/exception/editable_order_not_exists_exception.dart';
import 'package:virtual_waiter/exception/item_not_found_exception.dart';
import 'package:virtual_waiter/exception/multiple_editable_orders_exist_exception.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/model/order.dart';

class OrderDataController extends GetxController {
  static OrderDataController instance = Get.find();

  RxBool _isAddingOrder = false.obs;
  bool get isAddingOrder => _isAddingOrder.value;
  void setIsAddingOrder(bool value) {
    _isAddingOrder.value = value;
  }

  OrderListDataController _oldc = OrderListDataController.instance;
  OrderNetworkController _onc = OrderNetworkController.instance;
  WebSocketController _websc = WebSocketController.instance;
  SettingsDataController _tnc = SettingsDataController.instance;

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  RxList<OrderItem> _orderItemList = <OrderItem>[].obs;
  List<OrderItem> get orderItemList => _orderItemList;

  void addOrderItem({required OrderItem orderItem}) {
    _orderItemList.add(orderItem);
    _calculateTotalAmount();
    if (!_oldc.editableOrderExists()) {
      Order newOrder = Order(
        orderItemList: _orderItemList,
        orderStatus: Rx<OrderStatus>(OrderStatus.Editing),
        orderTotal: _totalAmount.value,
        tableId: 5,
      );
      _oldc.addOrder(newOrder);
    } else {
      try {
        _oldc.updateEditableOrder(orderTotal: _totalAmount.value);
      } on EditableOrderNotExistsException catch (e) {
        rethrow;
      } on MultipleEditableOrdersExistException catch (e) {
        rethrow;
      }
    }
    // add to editable
  }

  void removeItem({required int orderItemId}) {
    try {
      _orderItemList.removeWhere((item) => item.orderItemId == orderItemId);
      _calculateTotalAmount();
      _oldc.updateEditableOrder(orderTotal: _totalAmount.value);
      //remove item from editable
    } catch (e) {
      throw ItemNotFoundException(
          message:
              'Order Item $orderItemId does not exists in OrderDataController');
    }
  }

  bool orderItemExists({required String orderItemId}) {
    return _orderItemList.any((order) => order.orderItemId == orderItemId);
  }

  void _calculateTotalAmount() {
    double total = 0.0;
    for (OrderItem item in _orderItemList) {
      total += item.totalPrice;
    }
    _totalAmount.value = total.toPrecision(2);
  }

  Future<void> sendOrder() async {
    setIsAddingOrder(true);
    try {
      List<OrderItem> currentItems = [];
      double orderTotal = 0.0;
      orderTotal = _totalAmount.value;
      for (OrderItem item in _orderItemList) {
        currentItems.add(item);
      }

      Order order = Order(
        orderItemList: currentItems,
        orderStatus: Rx<OrderStatus>(OrderStatus.Pending),
        orderTotal: orderTotal,
        tableId: _tnc.tableNo,
      );
      _oldc.removeEditableOrder();

      Map<String, dynamic> newOrder =
          await _onc.addOrder(order: order); // add new order to the db
      _oldc.addOrder(Order.fromMap(newOrder));
      await _websc.updateAllOrderList(
          Order.fromMap(newOrder)); //update the order manager app in real time
      _orderItemList.clear();
    } catch (e) {
      print(e.toString());
    }
    setIsAddingOrder(false);
  }
}
