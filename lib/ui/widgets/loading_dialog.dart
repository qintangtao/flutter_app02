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
    final DialogTheme dialogTheme = DialogTheme.of(context);
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: SizedBox(
              height: ScreenUtil().setHeight((30 +
                  (2*(radius ?? 20)).toDouble()+
                  (fontSize ?? 13) +
                  30)),
              width: ScreenUtil().setWidth(130),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: ShapeDecoration(
                    color: backgroundColor ?? dialogTheme.backgroundColor ?? Theme.of(context).dialogBackgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(AppDimens.DIMENS_10),),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(
                        animating: true,
                        radius: ScreenUtil().setHeight(radius ?? 20),
                      ),
                      Padding(padding: EdgeInsets.all(ScreenUtil().setHeight(6))),
                      Text(
                        title ?? S.of(context).loading,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(fontSize ?? 13),
                          color: color ?? const Color(0xff999999),
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

