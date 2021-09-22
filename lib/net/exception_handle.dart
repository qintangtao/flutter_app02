import 'dart:io';

import 'package:dio/dio.dart';
import 'response_exception.dart';
import 'error.dart';

class ExceptionHandle {

  static ResponseException handleException(var e) {
    //debugPrint("handleException ${e.type} ${e.error}");
    if (e is DioError) {
      if(e.type == DioErrorType.other ||
          e.type == DioErrorType.response) {
        if (e.error is SocketException) {

        } else if (e.error is HttpException) {

        } else if (e.error is FormatException) {
          return ResponseException.error(ERROR.parse());
        }
        return ResponseException.error(ERROR.network());
      } else if (e.type == DioErrorType.connectTimeout ||
                  e.type == DioErrorType.sendTimeout ||
                  e.type == DioErrorType.receiveTimeout) {
        return ResponseException.error(ERROR.timeout());
      } else if (e.type == DioErrorType.cancel) {
        return ResponseException.error(ERROR.cancel());
      }
    } else if (e is ResponseException) {
      return e;
    }
    return ResponseException.error(ERROR.unknown());
  }


}