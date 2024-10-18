import 'dart:convert';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:virtual_waiter/constants/network_constants.dart';
import 'package:virtual_waiter/controllers/data/settings_data_controller.dart';
import 'package:virtual_waiter/model/order.dart';

class WebSocketController extends GetxController {
  static WebSocketController instance = Get.find();
  SettingsDataController _sdc = SettingsDataController.instance;

  late SIO.Socket _socket;

  WebSocketController._(); // private constructor for class

  static Future<WebSocketController> create() async {
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController() async {
    try {
      _socket = SIO.io(NetworkConstants.wsUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
        'path': '/ws',
      });
      _socket.connect();
      _socket.onConnect((_) {
        print('Connection established');
      });
      _socket.onConnectError((error) {
        print('Connection Error: $error');
      });

      _socket.onError((error) {
        print('WebSocket Error: $error');
      });

    } catch (e) {
      print("error occurs establishing the websocket");
      rethrow;
    }
  }

  Future<void> sendCustomerHelp() async {
    try {
      _socket.emit(
        'customerHelpAlert',
        jsonEncode(
          {
            'tableNo': _sdc.tableNo,
          },
        ),
      );
    } catch (e) {
      print('Error sending Customer Help');
      rethrow;
    }
  }

  Future<void> updateAllOrderList(Order order) async {
    try {
      _socket.emit(
        'newOrderAdded',
        jsonEncode(
          order.toMapWS(),
        ),
      );
    } catch (e) {
      print('Error occurs updating about new order');
    }
  }

  @override
  void onInit() {
    if (!_socket.connected) {
      _socket.connect();  // Ensure socket is only connected if it's not already
    }
    super.onInit();
  }
  @override
  void dispose() {
    _socket.disconnect();
    _socket.dispose();
    super.dispose();
  }
}
