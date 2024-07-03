import 'package:get/get.dart';
import 'package:virtual_waiter/controllers/network/webSocketController.dart';


class WelcomeScreenController extends GetxController {
    static WelcomeScreenController instance = Get.find();


    Future<void> tapBtnToRequestHelp() async{
        try{
            WebSocketController webSC = WebSocketController.instance;
            await webSC.sendCustomerHelp();
        }catch(e){
            print("error occurs send help request in welcomeScreen");
            rethrow;
        }
    }



}