import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:virtual_waiter/constants/network_constants.dart';
import 'package:virtual_waiter/exception/network_exception.dart';

import '../../model/order.dart';

class OrderNetworkController extends GetxController {
  static OrderNetworkController instance = Get.find();

  Future<Map<String, dynamic>> addOrder({required Order order}) async {
    try {
      Uri uri = Uri.parse('${NetworkConstants.baseUrl}/vw/singleTableOrder/add');
      var body = jsonEncode(order.toMap());
      print(body.toString());
      var response = await http.post(uri,
          headers: {
            'content-type': 'application/json',
          },
          body: body);

      if (response.statusCode == 201) {
        try {
          Map<String, dynamic> orderMap = jsonDecode(response.body) as Map<String,dynamic>;
          return orderMap;
        } catch (e) {
          print('add order request fail with status: ${response.statusCode}');
          throw NetworkException(message: 'error in jason decode in the add order');
        }
      } else {
        throw NetworkException(
            message:
                'Network error due to : status ${response.statusCode},${response.body}');
      }
    } catch (e) {
      print('Error adding new order');
      print(e.toString());
      throw NetworkException(message: e.toString());
    }
  }
}
