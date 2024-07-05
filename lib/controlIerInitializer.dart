import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/menu_data_controller.dart';
import 'package:virtual_waiter/controllers/network/menu_data_network_controller.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/checkBoxController.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/menu_grid_builder.dart';
import 'package:virtual_waiter/controllers/views/single_menu_item_screen/smis_state_controller.dart';

import 'controllers/network/webSocketController.dart';
import 'controllers/views/menuScreen/categoryButtonColorController.dart';
import 'controllers/views/menuScreen/categoryTabController.dart';
import 'controllers/views/welcomeScreenController.dart';

class ControllerInitializer {
  static bool _isIntialized = false;

  static bool get isInitialized => _isIntialized;

  static Future<void> initAllControllers() async {
    try {
      await Get.putAsync(() => WebSocketController.create());

      await Get.putAsync(() => MenuDataNetworkController.create());
      Get.put(MenuDataController());
      Get.put(MenuGridBuilder());
      Get.put(WelcomeScreenController());
      Get.put(CategoryTabController());
      Get.put(CategoryButtonColorController());
      Get.put(SmisStateController());
      Get.put(CheckboxController());

      _isIntialized = true;
    } catch (e) {
      print('An Unexpected error occurs initiating controller.');
      rethrow;
    }
  }
}
