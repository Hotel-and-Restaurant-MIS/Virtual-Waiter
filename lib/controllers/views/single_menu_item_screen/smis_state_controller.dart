
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

  void itemNullCheck() {
    if (menuItem == null) {
      throw Exception('MenuItem menuItem is null');
    }
  }




  void incrementQuantiy() {
    itemNullCheck();
    int temp = _quantity.value;
    temp++;
    _quantity.value = temp;
    update();
  }

  void decrementQuantiy() {
    itemNullCheck();
    int temp = _quantity.value;
    if (temp > 1) {
      temp--;
      _quantity.value = temp;
    }
    update();
  }

  void addAddOns({required String addOnId}){
    itemNullCheck();
    _selectedAddOnsDataMap[addOnId] = 1;
  _calculateTotal();
  }

  void removeAddOns({required String addOnId}){
    itemNullCheck();
    _selectedAddOnsDataMap.remove(addOnId);
    _calculateTotal();
  }



  String? _specialNotes = '';
  String? get specialNotes => _specialNotes;

  set specialNotes(String? value) => _specialNotes = value;

  void resetData() {
    _menuItem = null;
    _quantity.value = 1;
    //_selectedAddOnsQuantityMap = {};
    _selectedAddOnsDataMap = {};
    _totalAmount.value = 0;

  }


  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  void _calculateTotal(){
    itemNullCheck();
    double total = menuItem.price * _quantity.value;

    for(String addOnId in _selectedAddOnsDataMap.keys){
      double addOnPrice = menuItem.addOns.where((addOn)=>addOn['id']).toList().first['price'];
      total+=addOnPrice;
    }
    _totalAmount.value = total;
  }
}
