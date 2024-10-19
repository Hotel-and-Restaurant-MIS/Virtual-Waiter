import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/data/settings_data_controller.dart';
import 'package:virtual_waiter/controllers/network/web_socket_controller.dart';

class AllOrdersStateController extends GetxController{

  static AllOrdersStateController instance = Get.find();

  OrderListDataController _oldc = OrderListDataController.instance;
  SettingsDataController _sdc = SettingsDataController.instance;

  bool _hasEditableOrder = false;

  bool get hasEditableOrder => _hasEditableOrder;

  void setHasEditableOrder(bool value) {
    _hasEditableOrder = value;
  }

  RxBool _isGeneratedBill = false.obs;


  bool get isGeneratedBill => _isGeneratedBill.value;

  void setIsGeneratedBill(bool value) {
    _isGeneratedBill.value = value;
  }

  Future<void> generateBill()async{
    setIsGeneratedBill(true);
    _sdc.setIsBillRequested(true);
    _oldc.calculateAllOrdersTotal();
    await WebSocketController.instance.requestBill();
    setHasEditableOrder(_oldc.editableOrderExists());
    _oldc.removeEditableOrder();
    setIsGeneratedBill(false);
  }
}