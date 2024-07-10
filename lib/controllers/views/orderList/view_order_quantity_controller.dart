import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';

//view order quantity
class VoqController extends GetxController{
  VoqController({required int quantity}){
    _quantity.value = quantity;
  }

  OrderDataController _odc = OrderDataController.instance;

  RxInt _quantity = 0.obs;
  int get quantity => _quantity.value;

  void incrementQuantity({required int menuItemId}){
    bool itemExists = _odc.orderExists(itemId : menuItemId);
    if(itemExists){
      int curr = _quantity.value;
      curr++;
      _quantity.value = curr;
      _odc.incrementQuantity(itemId: menuItemId);
      update();
    }
  }

  void decrementQuantity({required int menuItemId}){
    bool itemExists = _odc.orderExists(itemId : menuItemId);
    if(itemExists){
      int curr = _quantity.value;
      if(curr > 1){
        curr--;
      }
      _quantity.value = curr;
      _odc.decrementQuantity(itemId: menuItemId);
      update();
    }
  }
}