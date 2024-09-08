import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/network/web_socket_controller.dart';


class WelcomeScreenController extends GetxController {
    static WelcomeScreenController instance = Get.find();


    Future<void> tapBtnToRequestHelp() async{
        try{
            WebSocketController _webSC = WebSocketController.instance;
            await _webSC.sendCustomerHelp();
        }catch(e){
            print("error occurs send help request in welcomeScreen");
            rethrow;
        }
    }



}