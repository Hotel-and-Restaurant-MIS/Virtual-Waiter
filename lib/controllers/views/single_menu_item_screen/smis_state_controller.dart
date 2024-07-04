import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/model/MenuItem.dart';

class SmisStateController extends GetxController {
  static SmisStateController instance = Get.find();
  Map<String, int> _selectedAddOnsDataMap = {};
  Map<String, RxInt> _selectedAddOnsQuantityMap = {};

  MenuItem? _menuItem;
  MenuItem get menuItem => _menuItem!;

  set menuItem(MenuItem item) {
    _menuItem = item;
    _selectedAddOnsDataMap = {};
    _selectedAddOnsQuantityMap = {};
    _totalAmount.value = item.price;
  }

  RxInt _quantity = 1.obs;
  int get quantity => _quantity.value;

  set quantity(int updatedQuantity) {
    _quantity.value = updatedQuantity;
    update();
  }

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  String? _specialNotes = '';
  String? get specialNotes => _specialNotes;

  set specialNotes(String? value) => _specialNotes = value;

  void resetData() {
    _menuItem = null;
    _quantity.value = 1;
    _selectedAddOnsQuantityMap = {};
    _selectedAddOnsDataMap = {};
    _totalAmount.value = 0;
  }
}
