import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/views/order_screen/order_state_controller.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/exception/editable_order_not_exists_exception.dart';
import 'package:virtual_waiter/exception/item_not_found_exception.dart';
import 'package:virtual_waiter/exception/multiple_editable_orders_exist_exception.dart';
import 'package:virtual_waiter/extension/list_upsert.dart';
import 'package:virtual_waiter/extensions.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/model/order.dart';

class TestOrderDataController extends GetxController {
  static TestOrderDataController instance = Get.find();

  OrderListDataController _oldc = OrderListDataController.instance;

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  RxList<OrderItem> _orderItemList = <OrderItem>[].obs;
  List<OrderItem> get orderItemList => _orderItemList;

  static const String _editableOrderConst = 'EditableOrderConst';

  void addOrderItem({required OrderItem orderItem}) {
    _orderItemList.add(orderItem);
    _calculateTotalAmount();
    if (!_oldc.editableOrderExists()) {
      Order newOrder = Order(
        orderId: _editableOrderConst,
        orderItemList: _orderItemList,
        orderStatus: OrderStatus.Editing,
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

  Future<Order> sendOrder() async {
    //TODO: use network controller to send data

    List<OrderItem> currentItems = [];

    double orderTotal = 0.0;

    for (OrderItem item in _orderItemList) {
      currentItems.add(item);
    }

    orderTotal = _totalAmount.value;

    Order order = Order(
      orderId: '001', //TODO: set from network response
      orderItemList: currentItems,
      orderStatus: OrderStatus.Pending,
      orderTotal: orderTotal,
      tableId: 5, //TODO: get from shared preferences
    );
    _oldc.removeEditableOrder();
    _oldc.addOrder(order);
    _orderItemList.clear();

    return order;
  }

  //TODO: Item update/delete error
  /*
  Two items are separately added for order item list. Need to update that
  When removing a single item from the above case, only one is removed while the other still remains. Need to fix that
   */
}
