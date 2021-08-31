import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/constant/app_dimens.dart';

class LoadingDialog extends StatelessWidget {

  const LoadingDialog({
    Key? key,
    this.title,
    this.fontSize,
    this.backgroundColor,
    this.color,
    this.radius,
  }) : super(key: key);

  final String? title;

  final double? fontSize;

  final Color? backgroundColor;

  final Color? color;

  final double? radius;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: SizedBox(
              height: ScreenUtil().setHeight((AppDimens.DIMENS_20 +
                  (2*(radius ?? AppDimens.DIMENS_60)).toDouble()+
                  (fontSize ?? AppDimens.DIMENS_42) +
                  AppDimens.DIMENS_120)),
              width: ScreenUtil().setHeight(AppDimens.DIMENS_400),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: ShapeDecoration(
                    color: backgroundColor ?? Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppDimens.DIMENS_10),),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(
                        animating: true,
                        radius: ScreenUtil().setHeight(radius ?? AppDimens.DIMENS_60),
                      ),
                      Padding(padding: EdgeInsets.all(ScreenUtil().setHeight(AppDimens.DIMENS_20))),
                      Text(
                        title ?? S.of(context).loading,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(this.fontSize ?? AppDimens.DIMENS_42),
                          color: color ?? Color(0xff999999),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

