import 'package:get/get.dart';

//view order quantity
class VoqController extends GetxController{
  VoqController({required int quantity}){
    _quantity.value = quantity;
  }

  // OrderDataController _odc = OrderDataController.instance;

  RxInt _quantity = 0.obs;
  int get quantity => _quantity.value;


}