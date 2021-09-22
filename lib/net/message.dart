import 'response_exception.dart';
import 'result.dart';
import 'error.dart';

class Message {

  Message(this.code, this.msg);

  factory Message.exception(ResponseException e) =>  Message(e.code, e.msg);
  factory Message.error(ERROR e) =>  Message(e.code, e.msg);
  factory Message.result(RESULT r) =>  Message(r.code, r.msg);

  int code;
  String msg;
}