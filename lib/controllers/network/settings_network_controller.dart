import 'package:get/get.dart';

class SettingNetworkController extends GetxController{
  static SettingNetworkController instance = Get.find();

  bool checkPassword(String password){
    String hardCordedPassword = 'ash';
    return (password == hardCordedPassword)? true:false;
    //TODO: check with the backend
  }
}
