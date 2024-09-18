import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/network/menu_data_network_controller.dart';
import 'package:virtual_waiter/model/menu_item.dart';

class MenuDataController extends GetxController {
  static MenuDataController instance = Get.find();

  MenuDataNetworkController _mdnc = MenuDataNetworkController.instance;

  Map<String, List<MenuItem>> _menuDataMap = {};
  Map<String, List<MenuItem>> get menuDataMap => _menuDataMap;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initController();
  }

  void _initController() {
    _mdnc.menuMap.entries.forEach((entry) {
      String category = entry.key;
      List itemList = entry.value;

      _menuDataMap[category] =
          itemList.map<MenuItem>((item) => MenuItem.fromMap(item)).toList();
    });
  }
}
