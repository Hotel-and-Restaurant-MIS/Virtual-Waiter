import 'package:virtual_waiter/exception/base_exception.dart';

class MultipleEditableOrdersExistException extends BaseException{
  MultipleEditableOrdersExistException({String? message}) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}