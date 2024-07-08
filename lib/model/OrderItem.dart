import 'package:get/get.dart';

class OrderItem {
  final int menuItemId;
  final String itemName;
  int quantity ;
  final List<String> addonList;
  String? specialNote;
  final double totalPrice;
  final double unitPrice;
  final String imageURL;

  OrderItem(
      {required this.quantity,
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
