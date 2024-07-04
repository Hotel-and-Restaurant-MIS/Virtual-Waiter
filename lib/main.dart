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
// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TabBarDemo(),
//     );
//   }
// }
//
// class TabBarDemo extends StatefulWidget {
//   @override
//   _TabBarDemoState createState() => _TabBarDemoState();
// }
//
// class _TabBarDemoState extends State<TabBarDemo> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 6, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tab Bar Demo'),
//         backgroundColor: Colors.black,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.orange,
//           indicatorWeight: 4.0,
//           unselectedLabelColor: Colors.white,
//           labelColor: Colors.orange,
//           tabs: [
//             Tab(text: 'Hot Dishes'),
//             Tab(text: 'Cold Dishes'),
//             Tab(text: 'Soup'),
//             Tab(text: 'Grill'),
//             Tab(text: 'Appetizer'),
//             Tab(text: 'Dessert'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Center(child: Text('Hot Dishes')),
//           Center(child: Text('Cold Dishes')),
//           Center(child: Text('Soup')),
//           Center(child: Text('Grill')),
//           Center(child: Text('Appetizer')),
//           Center(child: Text('Dessert')),
//         ],
//       ),
//     );
//   }
// }
