import 'package:get/get.dart';
import 'package:virtual_waiter/constants/category_names.dart';
import 'package:virtual_waiter/constants/menu_item_constants.dart';

class MenuDataNetworkController extends GetxController {
  static MenuDataNetworkController instance = Get.find();

  Map<String, dynamic> _menuMap = {};
  Map<String, dynamic> get menuMap => _menuMap;

  MenuDataNetworkController._();

  static Future<MenuDataNetworkController> create() async {
    MenuDataNetworkController controller = MenuDataNetworkController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    //To simulate network delay
    await Future.delayed(
      Duration(
        milliseconds: 500,
      ),
    );

    kCategoryNameList.forEach((category) => _menuMap[category] = []);
    kMenuItemList.forEach((item) {
      List currentList = _menuMap[item.category];
      currentList.add(item.toMap());
      _menuMap[item.category] = currentList;
    });
  }
}
