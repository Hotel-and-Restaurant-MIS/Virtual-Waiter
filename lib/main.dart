import 'package:flutter/material.dart';
import 'package:virtual_waiter/controllers/network/web_socket_controller.dart';
import 'package:virtual_waiter/controllers/views/welcome_screen_controller.dart';
import 'package:virtual_waiter/views/welcomeScreen.dart';
import 'package:get/get.dart';

void main() async {
  Get.putAsync(()=>
    WebSocketController.create()
  );
  Get.put(WelcomeScreenController());
  runApp(virtual_waiter());
}

class virtual_waiter extends StatelessWidget {
  const virtual_waiter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}
