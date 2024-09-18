import 'package:virtual_waiter/exception/base_exception.dart';

class NetworkException extends BaseException{
  NetworkException({String? message}) : super(message: message);

  @override
  String toString() {
    // TODO: implement toString
    return message ?? super.toString();
  }

}