import 'package:get/get.dart';
import 'package:virtual_waiter/extensions.dart';
import 'package:virtual_waiter/model/OrderItem.dart';


class OrderDataController extends GetxController{

  static OrderDataController instance = Get.find();

  List<OrderItem> _orderList =[];

  RxList<OrderItem> reactiveOrderList = <OrderItem>[].obs;  //this duplicate order List is create for change the quantity at the orderList

  List<OrderItem> get orderList => _orderList;


  void addOrderItem({required OrderItem orderItem}){
    _orderList.add(orderItem);
    reactiveOrderList.add(orderItem);
  }

  bool orderExists({required int itemId}){
    return _orderList.any((order) => order.menuItemId == itemId);
  }

  void incrementQuantity({required itemId}) {
    if(orderExists(itemId: itemId)){
      OrderItem item = _orderList.where((order) => order.menuItemId == itemId).toList().first;
      item.quantity++;
      _orderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
       reactiveOrderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
    }
  }




  void decrementQuantity({required itemId}) {
    if(orderExists(itemId: itemId)){
      OrderItem item = _orderList.where((order) => order.menuItemId == itemId).toList().first;
      if(item.quantity > 1)
        {
          item.quantity--;
        }
      _orderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
       reactiveOrderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
    }
  }

  void subTotal({required itemId}) {
    if(orderExists(itemId: itemId)){
      OrderItem item = _orderList.where((order) => order.menuItemId == itemId).toList().first;
      // item.quantity++;

      item.totalPrice=item.totalPrice+item.unitPrice;
      _orderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
      //where
      //indexWhere
      //removeWhere
      //updateWhere
      reactiveOrderList.updateWhere((order) => order.menuItemId == itemId, (result) => result = item);
    }
  }

  void removeItem({required int itemId}) {
    reactiveOrderList.removeWhere((order) => order.menuItemId == itemId);
  }

}