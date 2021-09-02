import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_app02/generated/l10n.dart' as INTL;

Future<String> showPicker(
    BuildContext context,
    List options,
    {List<int>? selecteds}) async {
  String? result;
  final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
  final ThemeData theme = Theme.of(context);
  final BottomSheetThemeData sheetTheme = theme.bottomSheetTheme;
  final bool isLight = theme.brightness == Brightness.light;

  await Picker(
    height: ScreenUtil().setHeight(180),
    itemExtent: ScreenUtil().setHeight(30),
    backgroundColor: sheetTheme.modalBackgroundColor ?? sheetTheme.backgroundColor,
    textStyle: defaultTextStyle.style.copyWith(
      fontSize: Picker.DefaultTextSize,
    ),
    cancelTextStyle: TextStyle(
      color: isLight ? theme.primaryColor : Colors.white,
      fontSize: ScreenUtil().setSp(18),
    ),
    confirmTextStyle: TextStyle(
      color: isLight ? theme.primaryColor : Colors.white,
      fontSize: ScreenUtil().setSp(18),
    ),
    adapter: PickerDataAdapter<String>(pickerdata: options),
    selecteds: selecteds,
    onConfirm: (Picker picker, List value) {
      result = options[value.first];
    }
  ).showModal(context);
  return result ?? '';
}

Future<String> showPickerDate(
    BuildContext context, {
      int? yearEnd,
    }) async {
  String? result;
  final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
  final ThemeData theme = Theme.of(context);
  final BottomSheetThemeData sheetTheme = theme.bottomSheetTheme;
  final bool isLight = theme.brightness == Brightness.light;
  await Picker(
    height: ScreenUtil().setHeight(180),
    itemExtent: ScreenUtil().setHeight(30),
    backgroundColor: sheetTheme.modalBackgroundColor ?? sheetTheme.backgroundColor,
    textStyle: defaultTextStyle.style.copyWith(
      fontSize: Picker.DefaultTextSize,
    ),
    cancelTextStyle: TextStyle(
      color: isLight ? theme.primaryColor : Colors.white,
      fontSize: ScreenUtil().setSp(18),
    ),
    confirmTextStyle: TextStyle(
      color: isLight ? theme.primaryColor : Colors.white,
      fontSize: ScreenUtil().setSp(18),
    ),
    adapter: DateTimePickerAdapter(
      type:PickerDateTimeType.kYMD,
      isNumberMonth: true,
      yearEnd: yearEnd ?? 2100,
      yearSuffix: INTL.S.of(context).year,
      monthSuffix: INTL.S.of(context).month,
      daySuffix: INTL.S.of(context).day,
    ),
    onConfirm: (Picker picker, List value) {
      result = formatDate(
        (picker.adapter as DateTimePickerAdapter).value ?? DateTime.now(),
        [yyyy, '-', mm, '-', dd]
        );
        print((picker.adapter as DateTimePickerAdapter).value?.toString());
    }).showModal(context);
  return result ?? '';
}

Future<String> showCityPicker(
    BuildContext context
    ) async {
  final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);

  Result? result = await CityPickers.showCityPicker(
    context: context,
    height: ScreenUtil().setHeight(220),
    itemExtent: ScreenUtil().setHeight(30),
    cancelWidget: Text(
      INTL.S.of(context).cancelText,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).primaryColor : Colors.white,
        fontSize: ScreenUtil().setSp(18),
      ),
    ),
    confirmWidget: Text(
      INTL.S.of(context).confirmText,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light ? Theme.of(context).primaryColor : Colors.white,
        fontSize: ScreenUtil().setSp(18),
      ),
    ),
    itemBuilder: (item, list, index) {
      String text = item;
      double fontSize = 13;
      if (text != null) {
        int len = text.length;
        if (len >= 1 && len <= 3) {
          fontSize = 20;
        } else if (len > 3 && len <= 4) {
          fontSize = 18;
        } else if (len > 4 && len <= 5) {
          fontSize = 16;
        } else if (len > 5 && len <= 6) {
          fontSize = 12;
        } else if (len > 6 && len <= 9) {
          fontSize = 10;
        } else if (len > 9) {
          fontSize = 8;
        }
      }
      return Center(
        child: Text(item,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          style: defaultTextStyle.style.copyWith(
            fontSize: fontSize,
          ),
        ),
      );
    },
  );
  return result != null ? "${result.provinceName}-${result.cityName}-${result.areaName}" : '';
}