import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:virtual_waiter/constant.dart';
import 'package:virtual_waiter/model/order.dart';

class WebSocketController extends GetxController {
  static WebSocketController instance =
      Get.find(); //create instance by using Singleton design pattern

  late SIO.Socket _socket;

  WebSocketController._(); // private constructor for class

  static Future<WebSocketController> create() async {
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    try {
      _socket = SIO.io('${kBackendURL}', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
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
    try {
      _socket.emit('customerHelpAlert');
    } catch (e) {
      print('Error sending Customer Help');
      rethrow;
    }
  }

  Future<void> updateAllOrderList() async{
    try{
      _socket.emit('orderListUpdated');
    }catch(e){
      print('Error occurs sending update to the order manager about added new order');
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _socket.connect();
    super.onInit();
  }
}
