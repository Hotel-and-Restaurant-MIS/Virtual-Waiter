import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/model/menu_item.dart';

class OrderItem {
  final int orderItemId;
  final MenuItem menuItem;
  int quantity;
  final List<int> selectedAddonList;
  String? specialNote;
  final double totalPrice;

  OrderItem(
      {required this.quantity,
      required this.orderItemId,
      required this.menuItem,
      required this.selectedAddonList,
      required this.specialNote,
      required this.totalPrice});

  set totalPrice(double value) => totalPrice = value;

  // Method to convert OrderItem to Map
  Map<String, dynamic> toMap() {
    return {
      'menuItemId': menuItem.id.toString(), // Assuming menuItem has an 'id' field
      'specialNote': specialNote ?? '',
      'totalPrice': totalPrice.toStringAsFixed(2),
      'quantity': quantity.toString(),
      'addonList': selectedAddonList.map((e) => e.toString()).toList(),
    };
  }
  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      orderItemId: map['orderItemId'],
      quantity: map['quantity'],
      specialNote: map['specialNote'],
      totalPrice: map['totalPrice'].toDouble(),
      menuItem: MenuItem.fromMap(map['menuItem']), // Map the nested menuItem
      selectedAddonList: map['selectedAddOns'] != null
          ? List<int>.from(map['selectedAddOns'].map((selectedAddOn) => selectedAddOn['addOn']['addOnId']))
          : [],
    );
  }

  @override
  String toString() {
    return 'OrderItem{menuItemId: ${menuItem.id}.,itemQuantity: $quantity total price: $totalPrice special note: $specialNote addon list: $selectedAddonList}';
  }
}
