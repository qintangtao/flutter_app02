
class ERROR {

  factory ERROR.unknown() => ERROR(1000, "未知错误");
  factory ERROR.parse() => ERROR(1001, "解析错误");
  factory ERROR.network() => ERROR(1002, "网络错误");
  factory ERROR.http() => ERROR(1003, "协议出错");
  factory ERROR.ssl() => ERROR(1004, "证书出错");
  factory ERROR.cancel() => ERROR(1005, "取消错误");
  factory ERROR.timeout() => ERROR(1006, "连接超时");

  ERROR(this.code, this.msg);

  int code;
  String msg;
}