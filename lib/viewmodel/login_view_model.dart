import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_app02/model/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app02/ui/widgets/list/list_notifier.dart';

class LoginViewModel with ChangeNotifier {

  //final users = ListNotifier<User>([]);
  final account = ValueNotifier<String>('18611659566');
  final password = ValueNotifier<String>('password');
  //final users = ListNotifier<User>([]);
  final users = ListNotifier<ValueNotifier<User>>([]);

  void init() {
    account.value = "asdf";
  }
/*
  Future<User> _login(String account, String password) async {
    bool result = true;

    print("LoginViewModel.login called.");

    await Future.delayed(const Duration(seconds: 3), () {
      print('delayed');
    });

    //throw Exception('网络异常');

    String jsonStr = '{"username":"flkutter","password":"pwd"}';
    Map<String,dynamic> decode = json.decode(jsonStr);

    User user = User.fromJson(decode);
    print("user.username=${user.username}, user.password=${user.username}");

    //password.value = user.password;

    print("LoginViewModel.login done.");
    return user;
  }

  void login(String account, String password)  {
    _login(account, password).then((value) => {
      user = value
    }, onError: (e) {

    });
  }

*/
  Future<bool> login(String account, String password) async {
    bool result = true;

    print("LoginViewModel.login called.");

    await Future.delayed(const Duration(seconds: 3), () {
      debugPrint('delayed');
    });

   //throw Exception('网络异常');

    String jsonStr = '{"username":"admin","password":"12346"}';
    Map<String,dynamic> decode = json.decode(jsonStr);

    User user = User.fromJson(decode);
    print("user.username=${user.username}, user.password=${user.username}");

    users.add(ValueNotifier<User>(user));

    await Future.delayed(const Duration(seconds: 3), () {
      debugPrint('delayed');
    });

    users.add(ValueNotifier<User>(user));

    await Future.delayed(const Duration(seconds: 3), () {
      debugPrint('delayed');
    });


    users[Random().nextInt(users.length-1)].value = User(username: "test ${Random().nextInt(100)}", password: '123456');

    //password.value = user.password;

    print("LoginViewModel.login done.");
    return result;
  }


}