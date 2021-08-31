import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToastUtil {

  static showToast(String msg, {
    BuildContext? context,
    double? fontSize,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Fluttertoast.showToast(msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: context!=null ? Theme.of(context).primaryColor : const Color(0xffff5E4C),
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? ScreenUtil().setSp(14),
    );
  }

}