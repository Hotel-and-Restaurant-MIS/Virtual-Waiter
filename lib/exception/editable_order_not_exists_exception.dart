import 'package:virtual_waiter/exception/base_exception.dart';

class EditableOrderNotExistsException extends BaseException{
  EditableOrderNotExistsException({String? message}) : super(message: message);

  @override
  String toString() => message ?? super.toString();
}