import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/data/menu_data_controller.dart';
import 'package:virtual_waiter/controllers/data/order_list_data_controller.dart';
import 'package:virtual_waiter/controllers/data/order_data_controller.dart';
import 'package:virtual_waiter/controllers/data/table_no_controller.dart';
import 'package:virtual_waiter/controllers/network/menu_data_network_controller.dart';
import 'package:virtual_waiter/controllers/network/order_network_controller.dart';
import 'package:virtual_waiter/controllers/views/all_orders_screen/all_orders_state_controller.dart';
import 'package:virtual_waiter/controllers/views/all_orders_screen/order_list_builder.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/check_box_controller.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/menu_grid_builder.dart';
import 'package:virtual_waiter/controllers/views/order_screen/order_state_controller.dart';
import 'package:virtual_waiter/controllers/views/single_menu_item_screen/smis_state_controller.dart';

import 'controllers/network/web_socket_controller.dart';
import 'controllers/views/menuScreen/category_button_color_controller.dart';
import 'controllers/views/menuScreen/category_tab_controller.dart';
import 'controllers/views/welcomeScreen/welcome_screen_controller.dart';

class ControllerInitializer {
  static bool _isIntialized = false;

  static bool get isInitialized => _isIntialized;

  static Future<void> initAllControllers() async {
    try {
      await Get.putAsync(() => WebSocketController.create());

      await Get.putAsync(() => MenuDataNetworkController.create());
      Get.put(TableNoController());
      Get.put(OrderNetworkController());
      Get.put(OrderListDataController());
      Get.put(AllOrdersStateController());
      Get.put(OrderDataController());
      Get.put(OrderStateController());


      Get.put(MenuDataController());

      Get.put(MenuGridBuilder());
      Get.put(OrderListBuilder());
      Get.put(WelcomeScreenController());
      Get.put(CategoryTabController());
      Get.put(CategoryButtonColorController());
      Get.put(SmisStateController());
      Get.put(CheckboxController());



      _isIntialized = true;
    } catch (e) {
      print('An Unexpected error occurs initiating controller.');
      print(e);
      rethrow;
    }
  }
}
