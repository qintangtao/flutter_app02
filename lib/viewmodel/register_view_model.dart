import 'package:flutter/material.dart';


class RegisterViewModel with ChangeNotifier {

  final account = ValueNotifier<String>('18611659566');
  final password = ValueNotifier<String>('password');

  Future<bool> register(String account, String password) async {
    bool result = false;

    await Future.delayed(const Duration(seconds: 1), () {
      print('delayed');
      result = true;
    });

    return result;
  }


}