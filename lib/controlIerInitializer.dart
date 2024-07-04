import 'package:get/get.dart';

import 'controllers/network/webSocketController.dart';
import 'controllers/views/menuScreen/categoryButtonColorController.dart';
import 'controllers/views/menuScreen/menuTabController.dart';
import 'controllers/views/welcomeScreenController.dart';

class ControllerInitializer {
  static bool _isIntialized = false;

  static bool get isInitialized => _isIntialized;

  static Future<void> initAllControllers() async {
    try {
      await Get.putAsync(() => WebSocketController.create());

      Get.put(WelcomeScreenController());
      Get.put(MenuTabController());
      //Get.put(CategoryButtonColorController());

      _isIntialized = true;
    } catch (e) {
      print('An Unexpected error occurs initiating controller.');
      rethrow;
    }
  }
}
