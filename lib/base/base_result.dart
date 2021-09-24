import 'net_result.dart';


class BaseResult<T> extends CResult<T> {

  BaseResult({required int errorCode, required String errorMsg})
    : _errorCode=errorCode,
      _errorMsg=errorMsg;

  @override
  int get code => _errorCode;

  @override
  String get msg => _errorMsg;

  @override
  T get data => _data!;

  set data(d) => _data = d;

  @override
  bool get isSuccess => code == 0;

  final int _errorCode;
  final String _errorMsg;
  T? _data;

  factory BaseResult.fromJson(Map<String, dynamic> json) => BaseResult(
    errorCode: json['errorCode'] as int,
    errorMsg: json['errorMsg'] as String,
  );

}



/*
class BaseResult<T> extends Result<T> {

  BaseResult(this._result);

  @override
  int get code => _result["errorCode"];

  @override
  String get msg => _result["errorMsg"];

  @override
  T? get data => _result["data"];

  @override
  bool get isSuccess => code == 0;

  final Map<String, dynamic> _result;
}*/