import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:virtual_waiter/constant.dart';

class WebSocketController extends GetxController {
  static WebSocketController instance = Get.find();   //create instance by using Singleton design pattern

  late SIO.Socket _socket;

  WebSocketController._();   // private constructor for class

  static Future<WebSocketController> create() async {
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    try {
      _socket = SIO.io(
          {kBackendURL},
          SIO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      _socket.onConnect((_) {
        print("Connected");
      });
      _socket.connect();
      print("Inited");
    } catch (e) {
      print("error occurs establishing the websocket");
      rethrow;
    }
  }

  Future<void> sendCustomerHelp() async {
    try{
      _socket.emit("customerHelpAlert");
    }catch(e){
      print("Error sending Customer Help");
      rethrow;
    }
  }
}
