import 'package:get/get.dart';

class TableNoController extends GetxController{
  static TableNoController instance = Get.find();

  RxInt _tableNo = 1.obs;

  int get tableNo => _tableNo.value;

  void setTableNo(int value) {
    _tableNo.value = value;
    print(value);
  }
}