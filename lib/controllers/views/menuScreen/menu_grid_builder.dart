import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_waiter/components/menu_item_tile.dart';
import 'package:virtual_waiter/controllers/data/menu_data_controller.dart';
import 'package:virtual_waiter/views/single_menu_item_screen.dart';

class MenuGridBuilder extends GetxController {
  static MenuGridBuilder instance = Get.find();
  MenuDataController _mdc = MenuDataController.instance;

  Widget buildGridByCategory({required String category}) {
    List<Widget> children = [];
    _mdc.menuDataMap[category]!.forEach((menuItem) {
      children.add(
        MenuItemTile(
          tags:menuItem.tags,
          id: menuItem.id,
          name: menuItem.name,
          price: menuItem.price,
          imageUrl: menuItem.imageUrl,
          onTap: (){
            Get.to(() =>SingleMenuItemScreen(menuItem: menuItem));
          },
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
            childAspectRatio: 320/270,
            mainAxisSpacing: 30,
            crossAxisCount: 2,
            children: children,
          ),
        ),
      ],
    );
  }
}
