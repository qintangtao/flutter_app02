import 'package:flutter/material.dart';


class LoginViewModel with ChangeNotifier {

  final account = ValueNotifier<String>('18611659566');
  final password = ValueNotifier<String>('password');


  Future<bool> login(String account, String password) async {
    bool result = true;

    print("LoginViewModel.login called.");

    await Future.delayed(const Duration(seconds: 3), () {
      print('delayed');
    });

   //throw Exception('网络异常');

    print("LoginViewModel.login done.");
    return result;
  }


}