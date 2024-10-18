import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_waiter/constants/network_constants.dart';
import 'package:virtual_waiter/exception/list_pass_exception.dart';
import 'package:virtual_waiter/exception/network_exception.dart';

class MenuDataNetworkController extends GetxController {
  static MenuDataNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> getMenuItems() async {
    List<Map<String, dynamic>> menuItemsMapList = [];
    try {
      Uri uri = Uri.parse('${NetworkConstants.baseUrl}/vw/menuItem/all');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        try {
          var jsonResponse = jsonDecode(response.body) as List;
          menuItemsMapList = jsonResponse
              .map((menuItem) => menuItem as Map<String, dynamic>)
              .toList();
          return menuItemsMapList;
        } catch (e) {
          throw ListPassException(
              message: 'List Passing error at getting menu items list ');
        }
      }else{
        throw NetworkException(
            message:
            'Network Error due to : Status ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error getting/parsing menu item data');
      print(e.toString());
      throw NetworkException(message: e.toString());
    }
  }
}
