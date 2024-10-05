import 'package:get/get.dart';
import 'package:virtual_waiter/constants/category_names.dart';
import 'package:virtual_waiter/controllers/network/menu_data_network_controller.dart';
import 'package:virtual_waiter/model/menu_item.dart';

class MenuDataController extends GetxController {
  static MenuDataController instance = Get.find();

  MenuDataNetworkController _mdnc = MenuDataNetworkController.instance;

  Map<String, List<MenuItem>> _menuDataMap = {};
  Map<String, List<MenuItem>> get menuDataMap => _menuDataMap;

  RxBool isGettingData = true.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initController();
  }

  void _initController() async {
    _getMenuItemsList();
  }

  Future<void> _getMenuItemsList() async {
    isGettingData.value = true;
    List<MenuItem> menuItemList = [];
    try {
      List<Map<String, dynamic>> menuItemsMapList = await _mdnc.getMenuItems();
      menuItemsMapList.forEach((Map<String, dynamic> menuMap) {
        menuItemList.add(MenuItem.fromMap(menuMap));
      });

      for (String category in kCategoryNameList) {
        List<MenuItem> filteredMEnuItems =
            menuItemList.where((item) => item.category == category).toList();
        _menuDataMap[category] = filteredMEnuItems;
      }

      print(_menuDataMap.entries);
    } catch (e) {
      print('error occurs getting menu data');
      print(e);
    }
    isGettingData.value = false;
  }
}

// _mdnc.menuMap.entries.forEach((entry) {
//   String category = entry.key;
//   List itemList = entry.value;
//
//   _menuDataMap[category] =
//       itemList.map<MenuItem>((item) => MenuItem.fromMap(item)).toList();
// });
