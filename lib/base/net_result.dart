

abstract class CResult<T> {

  int get code;
  String get msg;
  T get data;
  bool get isSuccess;

}