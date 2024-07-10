import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/model/menu-item.dart';

class OrderItem {
  final int menuItemId;
  final MenuItem menuItem;
  final String itemName;
  int quantity ;
  final List<String> addonList;
  String? specialNote;
  late final double totalPrice;
  final double unitPrice;
  final String imageURL;

  OrderItem(
      {required this.quantity,
        required this.menuItem,
      required this.imageURL,
      required this.unitPrice,
      required this.itemName,
      required this.menuItemId,
      required this.addonList,
      required this.specialNote,
      required this.totalPrice});

  @override
  String toString() {
    return 'OrderItem{menuItemId: $menuItemId,itemQuantity: $quantity total price: $totalPrice special note: $specialNote addon list: $addonList}';
  }
}
