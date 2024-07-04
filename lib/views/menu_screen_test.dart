import 'package:flutter/material.dart';
import 'package:virtual_waiter/components/menu_item_tile.dart';
import 'package:virtual_waiter/constants/categoryNames.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/menu_grid_builder.dart';

class MenuScreenTest extends StatelessWidget {
  const MenuScreenTest({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          bottom: TabBar(
            isScrollable: true,
            tabs: kCategoryNameList.map<Widget>((category) {
              return Tab(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50,
                  child: Text(
                    category,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: kCategoryNameList
              .map<Widget>(
                (category) => MenuGridBuilder.instance.buildGridByCategory(category: category),
              )
              .toList(),
        ),
      ),
    );
  }
}
