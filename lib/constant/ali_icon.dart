import 'package:flutter/widgets.dart';

class AliIcon{
  static const IconData password = _AliIconData(0xe734);
  static const IconData account = _AliIconData(0xe605);
  static const IconData coupon = _AliIconData(0xe647);
  static const IconData aboutUs = _AliIconData(0xe654);
}

class _AliIconData extends IconData {
  const _AliIconData(int codePoint)
    : super(codePoint, fontFamily: 'AliIcon');
}