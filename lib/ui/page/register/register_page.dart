import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/constant/app_dimens.dart';
import 'package:flutter_app02/constant/fm_icon.dart';
import 'package:flutter_app02/util/toast_util.dart';
import 'package:flutter_app02/util/dialog_util.dart';
import 'package:flutter_app02/viewmodel/register_view_model.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RegisterViewModel _registerViewModel = RegisterViewModel();

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_accountController.text = _registerViewModel.account.value;
    //_passWordController.text = _registerViewModel.password.value;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(S.of(context).register),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(AppDimens.DIMENS_60),
                right: ScreenUtil().setWidth(AppDimens.DIMENS_60),
                top: ScreenUtil().setWidth(AppDimens.DIMENS_160)
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).register_welcome,
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: ScreenUtil().setSp(AppDimens.DIMENS_60),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_20)),
                  ),
                  Text(
                    S.of(context).login_app_introduce,
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: ScreenUtil().setSp(AppDimens.DIMENS_36),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_100)),
                  ),
                  TextFormField(
                    maxLines: 1,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    validator: _validatorAccount,
                    decoration: InputDecoration(
                      icon: Icon(
                        FMICon.ACCOUNT,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                      ),
                      hintText: S.of(context).account_hint,
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                        fontSize: ScreenUtil().setSp(AppDimens.DIMENS_36),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff333333),
                        fontSize: ScreenUtil().setSp(AppDimens.DIMENS_42),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(AppDimens.DIMENS_20)),
                  ),
                  TextFormField(
                    maxLines: 1,
                    maxLength: 12,
                    obscureText: true,
                    validator: _validatorPassWord,
                    decoration: InputDecoration(
                      icon: Icon(
                        FMICon.PASSWORD,
                        color: Theme.of(context).primaryColor,
                        size: ScreenUtil().setWidth(AppDimens.DIMENS_80),
                      ),
                      hintText: S.of(context).password_hint,
                      hintStyle: TextStyle(
                        color: Color(0xff999999),
                        fontSize: ScreenUtil().setSp(AppDimens.DIMENS_36),
                      ),
                      labelStyle: TextStyle(
                        color: Color(0xff333333),
                        fontSize: ScreenUtil().setSp(AppDimens.DIMENS_42),
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
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(AppDimens.DIMENS_80))),
                  SizedBox(
                    width: double.infinity,
                    height: ScreenUtil().setHeight(AppDimens.DIMENS_120),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: ScreenUtil().setSp(AppDimens.DIMENS_42))),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(AppDimens.DIMENS_30))
                        )),
                      ),
                      onPressed: _register,
                      child: Text(
                        S.of(context).immediately_register,
                      ),
                    ),
                  ),
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

  void _register() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      print('register account: ${_accountController
          .text}, password:${_passWordController.text}');

      DialogUtil.showLoading(context);

      _registerViewModel
          .register(_accountController.text, _passWordController.text)
          .then((value) {
        if (value) {
          print('register true');
          ToastUtil.showToast(S.of(context).register_success, context: context);
        } else {
          print('register false');
        }
      }, onError: (e) {
        ToastUtil.showToast(e.toString(), context: context);
      }).whenComplete(() => Navigator.pop(context));
    }
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
