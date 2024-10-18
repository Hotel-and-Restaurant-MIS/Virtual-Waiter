import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/model/order_item.dart';
import 'package:virtual_waiter/model/menu_item.dart';


class SmisStateController extends GetxController {
  static SmisStateController instance = Get.find();
  List<int> _selectedAddOnList = [];
  List<String> _selectedAddonNames =[];

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

  void addAddOns({required int addOnId, required String addonName}) {
    itemNullCheck();
    _selectedAddOnList.add(addOnId);
    _selectedAddonNames.add(addonName);
    print('selected addon list : $_selectedAddOnList');
    _calculateTotal();
  }

  void removeAddOns({required int addOnId,required String addonName}) {
    itemNullCheck();
    if (_selectedAddOnList.any((currAddOn) => currAddOn == addOnId)) {
      _selectedAddOnList.remove(addOnId);
      _selectedAddonNames.remove(addonName);
    }

    _calculateTotal();
  }

  String? _specialNotes ;
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

    for (int addOnId in _selectedAddOnList) {
      double addOnPrice = menuItem.addOns
          .where((addOn) => addOn['addOnId'] == addOnId)
          .toList()
          .first['addOnPrice'];
      total += addOnPrice;
    }
    _totalAmount.value = total;
    print(_totalAmount.value);
  }

  void addOrder() {
    itemNullCheck();
    _orderDataController.addOrderItem(
        orderItem: OrderItem(
          orderItemId:  menuItem.id,
          menuItem: menuItem,
            quantity: _quantity.value,
            selectedAddonList: _selectedAddOnList,
            selectedAddonNames:_selectedAddonNames,
            specialNote: _specialNotes,
            totalPrice: _totalAmount.value));
  }
}
