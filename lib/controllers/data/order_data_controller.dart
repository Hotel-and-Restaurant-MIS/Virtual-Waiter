import 'package:get/get.dart';
import 'package:virtual_waiter/extensions.dart';
import 'package:virtual_waiter/model/OrderItem.dart';


class OrderDataController extends GetxController{

  static OrderDataController instance = Get.find();

  List<OrderItem> _orderList =[];

  RxList<OrderItem> reactiveOrderList = <OrderItem>[].obs;

  List get orderList => _orderList;

  void addOrderItem({required OrderItem orderItem}){
    _orderList.add(orderItem);
    reactiveOrderList.add(orderItem);
  }

  bool _orderExists({required int itemId}){
    return _orderList.any((order) => order.menuItemId == itemId);
  }

  void incrementQuantity({required itemId}) {
    if(_orderExists(itemId: itemId)){
      OrderItem item = _orderList.where((order) => order.menuItemId == itemId).toList().first;
      item.quantity++;
      _orderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
      //where
      //indexWhere
      //removeWhere
      //updateWhere
      reactiveOrderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
    }
  }

  //reactive list
  //reactive list object(quantity) <fail
  //list -> obeject -> update <fail

  void reset(){

  }

  void decrementQuantity({required itemId}) {
    if(_orderExists(itemId: itemId)){
      OrderItem item = _orderList.where((order) => order.menuItemId == itemId).toList().first;
      if(item.quantity > 1)
        {
          item.quantity--;
        }
      _orderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
      reactiveOrderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
    }
  }

}