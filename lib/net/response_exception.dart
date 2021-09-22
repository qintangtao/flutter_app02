import '../base/net_result.dart';
import 'error.dart';

class ResponseException implements Exception {

  ResponseException(this.code, this.msg);

  ResponseException.result(CResult r)
      : code = r.code,
        msg = r.msg;

  ResponseException.error(ERROR e)
      : code = e.code,
        msg = e.msg;

  int code;
  String msg;
}