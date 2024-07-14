import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/model/menu-item.dart';

class OrderItem {
  final String orderItemId;
  final MenuItem menuItem;

  int quantity;
  final List<String> addonList;
  String? specialNote;
  late final double totalPrice;

  OrderItem(
      {required this.quantity,
      required this.orderItemId,
      required this.menuItem,
      required this.addonList,
      required this.specialNote,
      required this.totalPrice});

  @override
  String toString() {
    return 'OrderItem{menuItemId: ${menuItem.id}.,itemQuantity: $quantity total price: $totalPrice special note: $specialNote addon list: $addonList}';
  }
}
