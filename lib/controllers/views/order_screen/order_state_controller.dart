import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/exception/item_not_found_exception.dart';
import 'package:virtual_waiter/model/order_item.dart';

class OrderStateController extends GetxController {
  static OrderStateController instance = Get.find();

  OrderDataController _odc = OrderDataController.instance;

  RxList<OrderItem> _itemList = <OrderItem>[].obs;
  List<OrderItem> get itemList => _itemList;

  void _initController() {
    _itemList.value = [];
    _itemList.value = _odc.orderItemList;
  }

  void refreshController() {
    _initController();
  }

  void removeItem({required int orderItemId}) {
    if(_itemList.any((item) => item.orderItemId == orderItemId))
      {
        _itemList.removeWhere((item) => item.orderItemId == orderItemId);
        try{
          _odc.removeItem(orderItemId: orderItemId);
        } on ItemNotFoundException catch(e){
          print(e.toString());
          rethrow;
        }
      }
    else
      {
        throw ItemNotFoundException(message: 'Order Item not found in OrderStateController');
      }
  }

  @override
  void onInit() {
    super.onInit();
    _initController();
  }
}
