import 'package:flutter/material.dart';
import 'package:flutter_app02/net/message.dart';
import 'package:flutter_app02/net/result.dart';
import 'package:flutter_app02/net/response_exception.dart';
import 'package:flutter_app02/base/net_result.dart';
import 'package:flutter_app02/net/exception_handle.dart';
import 'page_state.dart';

class BaseViewModel with ChangeNotifier {

  final startListenable = ValueNotifier<int>(0);
  final errorListenable = ValueNotifier<Message>(Message(0, ''));
  final resultListenable = ValueNotifier<Message>(Message(0, ''));
  final completeListenable = ValueNotifier<int>(0);

  int get errorCode => errorListenable.value.code;
  String get errorMsg => errorListenable.value.msg;

  int get resultCode => resultListenable.value.code;
  String get resultMsg => resultListenable.value.msg;

  bool _isDispose = false;
  bool get isDispose => _isDispose;

  PageState _state = PageState.loading;
  PageState get state => _state;
  set state(state) {
    _state = state;
    notifyListeners();
  }

  /*
  int? _code;
  int get code => _code!;
  set code(value) => _code = value;

  String? _message;
  String get message => _message!;
  set message(value) => _message = value;

  void Function()? onStart;
  void Function()? onCompleted;
*/


  void launchOnlyResult<T>(
      Future<CResult<T>> Function() block,
      RESULT Function(dynamic) success,
      { void Function(ResponseException)? error,
        void Function()? complete,
        bool loading=false
      }) {

    error ??= (e) { _callError(Message.exception(e)); };

    complete ??= () { _callComplete(); };

    if (loading) { _callStart(); }

    _handleException(
            () => block(),
            (value) { _executeResponse(value, (value) { _callResult(success(value)); }); },
            (e) { error!(e); },
            () {  complete!(); });
  }

  @override
  void notifyListeners() {
    debugPrint("view model notifyListeners");
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    debugPrint("view model dispose");
    super.dispose();
  }

  void _callStart() {
    startListenable.notifyListeners();
    state = PageState.loading;
  }

  void _callError(Message msg) {
    errorListenable.value = msg;
    state = PageState.error;
  }

  void _callResult(RESULT result) {
    resultListenable.value = Message.result(result);
    if (result.code == RESULT.success().code) {
      state = PageState.success;
    } else if (result.code == RESULT.empty().code) {
      state = PageState.empty;
    }
  }

  void _callComplete() {
    completeListenable.notifyListeners();
    //onCompleted!();
  }

  void _handleException<T>(
      Future<CResult<T>> Function() block,
      void Function(CResult<T>) success,
      void Function(ResponseException) error,
      void Function() complete
      ) {
    //debugPrint("_handleException called.");
    block.call().then((value) {
      //debugPrint("_handleException then called.");
      success(value);
      //debugPrint("_handleException then done.");
    }).catchError((e) {
      //debugPrint("_handleException error called. ${e}");
      error(ExceptionHandle.handleException(e));
      //debugPrint("_handleException error done.");
    }) .whenComplete(() {
      //debugPrint("_handleException complete called.");
      complete();
      //debugPrint("_handleException complete done.");
    });
    //debugPrint("_handleException done.");
  }

  void _handleException2<T, T2>(
      Future<CResult<T>> Function() block,
      bool Function(CResult<T>) success,
      Future<CResult<T2>> Function() block2,
      void Function(CResult<T2>) success2,
      void Function(ResponseException) error,
      void Function() complete
      ) {
    debugPrint("_handleException called.");
    block.call().then((value) {
      debugPrint("_handleException then called.");
      if (success(value)) {
        debugPrint("_handleException block2 called.");
        block2.call().then((value2) {
          debugPrint("_handleException then2 called.");
          success2(value2);
          debugPrint("_handleException then2 done.");
        }).catchError((e) {
          debugPrint("_handleException error2 called. ${e}");
          error(ExceptionHandle.handleException(e));
          debugPrint("_handleException error2 done.");
        }) .whenComplete(() {
          debugPrint("_handleException complete2 called.");
          complete();
          debugPrint("_handleException complete2 done.");
        });
        debugPrint("_handleException block2 done.");
      }
      debugPrint("_handleException then done.");
    }).catchError((e) {
      debugPrint("_handleException error called. ${e}");
      error(ExceptionHandle.handleException(e));
      debugPrint("_handleException error done.");
    }) .whenComplete(() {
      debugPrint("_handleException complete called.");
      complete();
      debugPrint("_handleException complete done.");
    });
    debugPrint("_handleException done.");
  }

  void _executeResponse<T>(
      CResult<T> result,
      void Function(T) success
      ) {
    if (result.isSuccess) {
      success(result.data!);
    } else {
      throw  ResponseException.result(result);
    }
  }
}
