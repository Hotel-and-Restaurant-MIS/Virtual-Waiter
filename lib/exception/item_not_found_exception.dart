import 'package:virtual_waiter/exception/base_exception.dart';

class ItemNotFoundException extends BaseException{
  ItemNotFoundException({String? message}):super(message: message);

  @override
  String toString() => message ?? super.toString();
}