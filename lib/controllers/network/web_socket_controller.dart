import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;

class WebSocketController extends GetxController{
  static WebSocketController instance = Get.find();

  late SIO.Socket _socket;

  WebSocketController._();

  static Future<WebSocketController> create() async{
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async{
    // TODO:fill this out

  }

}