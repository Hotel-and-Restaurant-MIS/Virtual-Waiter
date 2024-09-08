import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/network/web_socket_controller.dart';
import 'package:virtual_waiter/controllers/views/welcomeScreen/welcome_screen_controller.dart';
import 'package:virtual_waiter/views/loading_screen.dart';
import 'package:virtual_waiter/views/welcome_screen.dart';
import 'package:virtual_waiter/views/menu_screen.dart';


void main() async {
  runApp(virtual_waiter());
}

class virtual_waiter extends StatelessWidget {
  const virtual_waiter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}


