import 'package:virtual_waiter/exception/base_exception.dart';

class ListPassException extends BaseException{
  ListPassException({String? message}) : super(message: message);

  @override
  String toString() {
    return message ?? super.toString();
  }
}