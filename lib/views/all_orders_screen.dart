import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/views/all_orders_screen/order_list_builder.dart';
import 'package:virtual_waiter/views/menu_screen.dart';

import '../constant.dart';

class AllOrdersScreen extends StatelessWidget {
  const AllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.offAll(() => MenuScreen());
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.black38,
        shadowColor: Colors.grey,
        toolbarHeight: 100.0,
        title: Text(
          'My Orders',
          style: TextStyle(
            fontFamily: 'Barlow',
            fontSize: 28.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            double deviceWidth = MediaQuery.of(context).size.width;
            double deviceHeight = MediaQuery.of(context).size.height;
            return SingleChildScrollView(
              child: Column(
                children: OrderListBuilder.instance.buildOrderList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
