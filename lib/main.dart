
import 'package:flutter/material.dart';
import 'package:virtual_waiter/Screens/welcomeScreen.dart';

void main() => runApp(virtual_waiter());

class virtual_waiter extends StatelessWidget {
  const virtual_waiter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}
