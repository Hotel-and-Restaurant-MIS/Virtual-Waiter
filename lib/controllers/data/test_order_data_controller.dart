import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/views/order_screen/order_state_controller.dart';
import 'package:virtual_waiter/enum/order_status.dart';
import 'package:virtual_waiter/exception/editable_order_not_exists_exception.dart';
import 'package:virtual_waiter/exception/item_not_found_exception.dart';
import 'package:virtual_waiter/exception/multiple_editable_orders_exist_exception.dart';
import 'package:virtual_waiter/extensions.dart';
import 'package:virtual_waiter/model/OrderItem.dart';
import 'package:virtual_waiter/model/order.dart';

class TestOrderDataController extends GetxController {
  static TestOrderDataController instance = Get.find();

  OrderListDataController _oldc = OrderListDataController.instance;

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  RxList<OrderItem> _orderItemList = <OrderItem>[].obs;
  List<OrderItem> get orderItemList => _orderItemList;

  void addOrderItem({required OrderItem orderItem}) {
    // _addOrUpdateToList(_orderItemList, orderItem);

    _orderItemList.add(orderItem);
    _calculateTotalAmount();
    if (!_oldc.editableOrderExists() && _oldc.orderList.isNotEmpty) {
      Order newOrder = Order(
        orderId: '0',
        orderItemList: _orderItemList,
        orderStatus: OrderStatus.Editing,
        orderTotal: _totalAmount.value,
        tableId: 5,
      );
      _oldc.addOrder(newOrder);
    } else {
      try {
        Order editableOrder = _oldc.getEditableOrder();
      } on EditableOrderNotExistsException catch (e) {
      } on MultipleEditableOrdersExistException catch (e) {}
    }

    // add to editable
  }

  //check current order List has this orderItem. if exist update the current quantity. else create a new orderItem.
  // void _testAddOrUpdateToList(List<OrderItem> orderItemList,
  //     OrderItem newOrderItem,){
  //   if(orderItemList.any((item)=>item.menuItem.id == newOrderItem.menuItem.id)){
  //     item.quantity = item.quantity + newOrderItem.quantity;
  //   }else{}
  // }

  void removeItem({required String orderItemId}) {
    try {
      _orderItemList.removeWhere((item) => item.orderItemId == orderItemId);
      //remove item from editable
    } catch (e) {
      throw ItemNotFoundException(
          message:
              'Order Item $orderItemId does not exists in OrderDataController');
    } finally {
      _calculateTotalAmount();
    }
  }

  bool orderItemExists({required String orderItemId}) {
    return _orderItemList.any((order) => order.orderItemId == orderItemId);
  }

  void _calculateTotalAmount() {
    double total = 0.0;
    _orderItemList.forEach((OrderItem item) {
      total += item.totalPrice;
    });
    _totalAmount.value = total.toPrecision(2);
  }

  Future<Order> sendOrder() async {
    //TODO: use network controller to send data
    Order order = Order(
      orderId: '0', //TODO: set from network response
      orderItemList: orderItemList,
      orderStatus: OrderStatus.Pending,
      orderTotal: _totalAmount.value,
      tableId: 5, //TODO: get from shared preferences
    );

    _orderItemList.clear();

    return order;
  }

  //TODO: Item update/delete error
  /*
  Two items are separately added for order item list. Need to update that
  When removing a single item from the above case, only one is removed while the other still remains. Need to fix that
   */
}
