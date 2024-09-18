import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/network/settings_network_controller.dart';

class SettingsDataController extends GetxController{
  static SettingsDataController instance = Get.find();

  SettingNetworkController _snc = SettingNetworkController.instance;

  bool _firstTry =true;

  bool get firstTry => _firstTry;

  void setFirstTry(bool value) {
    _firstTry = value;
  }

  RxInt _tableNo = 1.obs;

  int get tableNo => _tableNo.value;

  void setTableNo(int value) {
    _tableNo.value = value;
    print(value);
  }
  String? _password;

  String? get password => _password;

  void setPassword(String value) {
    _password = value;
  }

  RxBool _isValidUser = false.obs;

  bool get isValidUser => _isValidUser.value;

  void setIsValidUser(bool value) {
    _isValidUser.value = value;
  }

  void checkPassword(){
    bool isValid = _snc.checkPassword(password!);
    setIsValidUser(isValid);
    setFirstTry(false);
  }

  void loggedOutUser(){
    setIsValidUser(false);
    setPassword('');
    setFirstTry(true);
  }

}
