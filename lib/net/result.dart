

class RESULT {

  factory RESULT.success() => RESULT(0, "有数据");
  factory RESULT.end() => RESULT(1, "没有更多数据了");
  factory RESULT.empty() => RESULT(2, "暂无数据");

  RESULT(this.code, this.msg);

  int code;
  String msg;
}