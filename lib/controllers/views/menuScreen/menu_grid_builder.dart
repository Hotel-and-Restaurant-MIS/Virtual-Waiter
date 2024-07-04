import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/menu_item_tile.dart';
import 'package:virtual_waiter/controllers/data/menu_data_controller.dart';

class MenuGridBuilder extends GetxController {
  static MenuGridBuilder instance = Get.find();
  MenuDataController _mdc = MenuDataController.instance;

  Widget buildGridByCategory({required String category}) {
    List<Widget> children = [];
    _mdc.menuDataMap[category]!.forEach((menuItem) {
      children.add(
        MenuItemTile(
          id: menuItem.id,
          name: menuItem.name,
          price: menuItem.price,
          availableQuantity: menuItem.availableQuantity,
          imageUrl: menuItem.imageUrl,
          onTap: (){},
        ),
      );
    });
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: children,
          ),
        ),
      ],
    );
  }
}
