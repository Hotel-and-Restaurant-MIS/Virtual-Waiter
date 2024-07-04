import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MenuTabController extends GetxController with GetSingleTickerProviderStateMixin{
  static MenuTabController instance = Get.find();

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

}