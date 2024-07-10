import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/model/OrderItem.dart';
import 'package:virtual_waiter/model/menu-item.dart';

class SmisStateController extends GetxController {
  static SmisStateController instance = Get.find();
  List<String> _selectedAddOnList = [];

  MenuItem? _menuItem;
  MenuItem get menuItem => _menuItem!;

  final OrderDataController _orderDataController = OrderDataController.instance;

  set menuItem(MenuItem item) {
    _menuItem = item;
    _selectedAddOnList = [];
    _totalAmount.value = item.price;
  }

  RxInt _quantity = 1.obs;
  int get quantity => _quantity.value;

  set quantity(int updatedQuantity) {
    _quantity.value = updatedQuantity;
    update();
  }

  void itemNullCheck() {
    if (menuItem == null) {
      throw Exception('MenuItem menuItem is null');
    }
  }

  void incrementQuantity() {

    itemNullCheck();
    int temp = _quantity.value;
    temp++;
    _quantity.value = temp;
    update();
    _calculateTotal();
    print('AddSubButton Value :${_quantity.value}');
  }

  void decrementQuantity() {
    itemNullCheck();
    int temp = _quantity.value;
    if (temp > 1) {
      temp--;
      _quantity.value = temp;
    }
    update();
    _calculateTotal();
  }

  void addAddOns({required String addOnId}) {
    itemNullCheck();
    _selectedAddOnList.add(addOnId);
    print(_selectedAddOnList);
    _calculateTotal();
  }

  void removeAddOns({required String addOnId}) {
    itemNullCheck();
    if (_selectedAddOnList.any((currAddOn) => currAddOn == addOnId)) {
      _selectedAddOnList.remove(addOnId);
    }

    _calculateTotal();
  }

  String? _specialNotes = 'first as init';
  String? get specialNotes => _specialNotes;

  //set specialNotes(String? value) => _specialNotes = value;

  void specialNote(String note) {
    itemNullCheck();
    _specialNotes = note;
    update();
  }

  void resetData() {
    _menuItem = null;
    _quantity.value = 1;
    //_selectedAddOnsQuantityMap = {};
    // _selectedAddOnList = {};
    _totalAmount.value = 0;
  }

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  void _calculateTotal() {
    itemNullCheck();
    double total = menuItem.price * _quantity.value;

    for (String addOnId in _selectedAddOnList) {
      double addOnPrice = menuItem.addOns
          .where((addOn) => addOn['id'] == addOnId)
          .toList()
          .first['price'];
      total += addOnPrice;
    }
    _totalAmount.value = total;
    print(_totalAmount.value);
  }

  void addOrderList() {
    itemNullCheck();
    _orderDataController.addOrderItem(
        orderItem: OrderItem(
          menuItem: menuItem,
          imageURL: menuItem.imageUrl,
          unitPrice: menuItem.price,
          itemName: menuItem.name,
            quantity: _quantity.value,
            menuItemId: menuItem.id,
            addonList: _selectedAddOnList,
            specialNote: _specialNotes,
            totalPrice: _totalAmount.value));
  }

}
