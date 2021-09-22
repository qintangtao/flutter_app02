import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/constant/app_dimens.dart';
import 'package:flutter_app02/constant/ali_icon.dart';
import 'package:flutter_app02/util/toast_util.dart';
import 'package:flutter_app02/util/dialog_util.dart';
import 'package:flutter_app02/viewmodel/login_view_model.dart';
import 'package:flutter_app02/ui/page/register/register2_page.dart';
import 'package:flutter_app02/ui/widgets/list/list_listenable_builder.dart';
import 'package:flutter_app02/model/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _accountKey = GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _passwordKey = GlobalKey<FormFieldState<String>>();

  final LoginViewModel _loginViewModel = LoginViewModel();

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  final FocusNode _accountFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accountController.text = _loginViewModel.account.value;
    _passWordController.text = _loginViewModel.password.value;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('_LoginPageState build');
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(S.of(context).login),
        //backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(AppDimens.DIMENS_20),
              right: ScreenUtil().setWidth(AppDimens.DIMENS_20),
              top: ScreenUtil().setWidth(60)
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).login_welcome,
                    style: TextStyle(
                      color: isDark ? Colors.white : const Color(0xff333333),
                      fontSize: ScreenUtil().setSp(AppDimens.DIMENS_20),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_6)),
                  ),
                  Text(
                    S.of(context).login_app_introduce,
                    style: TextStyle(
                      color: const Color(0xff999999),
                      fontSize: ScreenUtil().setSp(12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_50)),
                  ),
                  TextFormField(
                    key: _accountKey,
                    maxLines: 1,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    validator: _validatorAccount,
                    decoration: InputDecoration(
                      icon: Icon(
                        AliIcon.account,
                        color: isDark ? Colors.white60 : Theme.of(context).primaryColor,
                        size: ScreenUtil().setWidth(AppDimens.DIMENS_30),
                      ),
                      hintText: S.of(context).account_hint,
                      hintStyle: TextStyle(
                        color: const Color(0xff999999),
                        fontSize: ScreenUtil().setSp(13),
                      ),
                      labelStyle: TextStyle(
                        color: const Color(0xff333333),
                        fontSize: ScreenUtil().setSp(AppDimens.DIMENS_15),
                      ),
                      labelText: S.of(context).account,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ),
                      ),
                    ),
                    controller: _accountController,
                    focusNode: _accountFocusNode,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_6)),
                  ),
                  TextFormField(
                    key: _passwordKey,
                    maxLines: 1,
                    maxLength: 12,
                    obscureText: true,
                    validator: _validatorPassWord,
                    decoration: InputDecoration(
                      icon: Icon(
                        AliIcon.password,
                        color: isDark ? Colors.white60 : Theme.of(context).primaryColor,
                        size: ScreenUtil().setWidth(AppDimens.DIMENS_30),
                      ),
                      hintText: S.of(context).password_hint,
                      hintStyle: TextStyle(
                        color: const Color(0xff999999),
                        fontSize: ScreenUtil().setSp(13),
                      ),
                      labelStyle: TextStyle(
                        color: const Color(0xff333333),
                        fontSize: ScreenUtil().setSp(AppDimens.DIMENS_15),
                      ),
                      labelText: S.of(context).password,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    controller: _passWordController,
                    focusNode: _passwordFocusNode,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_40))),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(40),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: ScreenUtil().setSp(18))),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setHeight(20)))
                        )),
                      ),
                      onPressed: _login,
                      child: Text(
                        S.of(context).login,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(12))),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(
                        right: ScreenUtil().setWidth(6)),
                    child: InkWell(
                      onTap: _register,
                      child: Text(
                        S.of(context).immediately_register,
                        style: TextStyle(
                          //color: const Color(0xff333333),
                          fontSize: ScreenUtil().setSp(14),
                        ),
                      ),
                    ),
                  ),
                  /*
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(600),
                    child: InkWell(
                      onTap: _register,
                      child: ListListenableBuilder<ValueNotifier<User>>(
                        valueListenable: _loginViewModel.users,
                        builder: (context, users, child)  {
                          return ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              debugPrint("ListListenableBuilder build ${index}");
                              return ValueListenableBuilder<User>(
                                valueListenable: users[index],
                                builder: (context, user, child)  {
                                  debugPrint("ValueListenableBuilder build ${user.username} ${user.password}");
                                  return ListTile(
                                    title: Text(user.username),
                                    subtitle: Text(user.password),
                                  );
                                }
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  */
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _accountController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  void _unfocus() {
    _accountFocusNode.unfocus();
    _passwordFocusNode.unfocus();
  }

  void _login() {
    //FocusScope.of(context).unfocus();
    _unfocus();
    if (_formKey.currentState?.validate() ?? false) {

      print('login account: ${_accountController.text}, password:${_passWordController.text}');
      print('login account: ${_accountKey.currentState?.value}, password:${_passwordKey.currentState?.value}');

      DialogUtil.showLoading(context);

      _loginViewModel
          .login(_accountController.text, _passWordController.text)
          .then((value) {
        if (value) {
          print('login true');
          //Navigator.pop(context);
        } else {
          print('login false');
        }
      }, onError: (e) {
        ToastUtil.showToast(e.toString(), context: context);
      }).whenComplete(() => Navigator.pop(context));
    }
  }

  void _register() {
    print('register');
    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  String? _validatorAccount(String? value) {
    if ((value?.length ?? 0) < 11 ) {
      return S.of(context).account_rule;
    }
    return null;
  }

  String? _validatorPassWord(String? value) {
    if ((value?.length ?? 0) < 6 ) {
      return S.of(context).password_rule;
    }
    return null;
  }
}