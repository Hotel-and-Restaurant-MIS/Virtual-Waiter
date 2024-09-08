import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:virtual_waiter/constants/network_constants.dart';
import 'package:virtual_waiter/exception/network_exception.dart';

import '../../model/order.dart';

class OrderNetworkController extends GetxController{

   static OrderNetworkController instance = Get.find();

   Future<Map<String, dynamic>> addOrder({required Order order}) async{

     Map<String,dynamic> orderMap ={};

     Uri uri = Uri.parse('${NetworkConstants.baseUrl}/order/add');
     var response = await http.post(uri,body: order);

     if(response.statusCode == 200){
       try{
         orderMap = response as Map<String,dynamic>;
         return orderMap;
       }catch(e){
            print(e);
       }
     }
     else{
       throw NetworkException(message: 'Network error due to : status ${response.statusCode},${response.body}');
     }
     return orderMap;
   }

  }