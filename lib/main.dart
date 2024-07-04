import 'package:flutter/material.dart';
import 'package:virtual_waiter/controllers/network/webSocketController.dart';
import 'package:virtual_waiter/controllers/views/welcomeScreenController.dart';
import 'package:virtual_waiter/views/loadingScreen.dart';
import 'package:virtual_waiter/views/welcomeScreen.dart';
import 'package:virtual_waiter/views/menuScreen.dart';
import 'package:get/get.dart';

void main() async {
  runApp(virtual_waiter());
}

class virtual_waiter extends StatelessWidget {
  const virtual_waiter({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      home: Loadingscreen(),
    );
  }
}


