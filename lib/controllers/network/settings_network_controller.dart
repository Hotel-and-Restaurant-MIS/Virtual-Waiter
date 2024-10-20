import 'package:get/get.dart';

class SettingNetworkController extends GetxController{
  static SettingNetworkController instance = Get.find();

  bool checkPassword(String password){
    String Password = '1234';
    return (password == Password)? true:false;
  }
}
