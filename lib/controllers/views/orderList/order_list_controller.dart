import 'package:get/get.dart';
import 'package:virtual_waiter/model/OrderItem.dart';

class OrderListController extends GetxController{
  static OrderListController instance = Get.find();

  OrderItem? _orderItem;
  OrderItem get orderItem => _orderItem!;



}