import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CheckboxController extends GetxController {
  static CheckboxController instance = Get.find();
  RxBool isChecked = false.obs;

  void toggleCheckbox(bool? value) {
    isChecked.value = value ?? false;
  }
}
