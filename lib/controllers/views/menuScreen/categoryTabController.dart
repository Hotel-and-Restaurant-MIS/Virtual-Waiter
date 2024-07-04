import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:virtual_waiter/constants/categoryNames.dart';
import 'package:virtual_waiter/controllers/views/menuScreen/categoryButtonColorController.dart';
import 'package:virtual_waiter/components/categoryButton.dart';

class CategoryTabController extends GetxController {
  List<Widget> _categoryList = [];
  List<Widget> get categoryList => _categoryList;
  var selectedIndex = 0.obs;
  int i=0;

  static CategoryTabController instance = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _buildCategoryTab();
  }

  void _buildCategoryTab() {
    for (String name in kCategoryNameList) {
      _categoryList.add(Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: CategoryButton(
          categoryName: name,
          isCategorySelect: false,
          categoryNo: i,
          onPressed: () {
            print('search ${name} and fetch data');
            //CategoryButtonColorController.instance.changeColor(categoryNO);
            print('id is : ${i}');
          },
        ),
      ));
      i++;
    }
  }
}
