import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/model/OrderItem.dart';

import '../../../components/add_sub_button.dart';
import '../../../constants/text_constants.dart';

class OrderListController extends GetxController {
  static OrderListController instance = Get.find();

  OrderDataController _odc = OrderDataController.instance;

  RxList<OrderItem> _itemList = <OrderItem>[].obs;
  List<OrderItem> get itemList => _itemList;

  void _initController() {
    _itemList.value = [];
    _itemList.value = _odc.orderList;
  }

  void refreshController() {
    _initController();
  }

  void removeItem({required int menuItemId}){
    if(_odc.orderExists(itemId: menuItemId)){
      _itemList.removeWhere((order) => order.menuItemId == menuItemId);
      _odc.removeItem(itemId : menuItemId);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initController();
  }
}
