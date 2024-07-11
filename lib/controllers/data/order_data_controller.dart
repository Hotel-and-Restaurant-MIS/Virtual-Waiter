import 'package:get/get.dart';
import 'package:virtual_waiter/extensions.dart';
import 'package:virtual_waiter/model/OrderItem.dart';


class OrderDataController extends GetxController{

  static OrderDataController instance = Get.find();

  List<OrderItem> _orderList =[];

  RxList<OrderItem> reactiveOrderList = <OrderItem>[].obs;  //this duplicate order List is create for change the quantity at the orderList

  List<OrderItem> get orderList => _orderList;




  //RxDouble get orderTotal => _orderTotal;




  void addOrderItem({required OrderItem orderItem}){
    _orderList.add(orderItem);
    reactiveOrderList.add(orderItem);
    print('order item id :${orderItem.orderItemId}');
  }

  bool orderExists({required String orderItemId}){
    return _orderList.any((order) => order.orderItemId == orderItemId);
  }


}