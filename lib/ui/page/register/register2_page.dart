import 'package:flutter/material.dart';
import 'package:tform/tform.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/util/toast_util.dart';
import 'package:flutter_app02/util/dialog_util.dart';
import 'package:flutter_app02/util/picker_util.dart';
import 'package:flutter_app02/viewmodel/register_view_model.dart';
import 'package:flutter_app02/ui/widgets/verifitionc_code_button.dart';
import 'package:flutter_app02/ui/widgets/photos_cell.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<TFormState> _formKey = GlobalKey<TFormState>();

  final RegisterViewModel _registerViewModel = RegisterViewModel();

  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  final List<TFormRow> _formRows = [
    TFormRow.input(
      enabled: true,
      title: "姓名",
      placeholder: "请输入姓名",
      value: "张三",
    ),
    TFormRow.input(
      title: '手机号',
      placeholder: '请输入手机号',
      maxLength: 11,
      requireMsg: '请输入正确的手机号',
      requireStar: true,
      keyboardType: TextInputType.phone,
      validator: (row) {
        return RegExp(
            r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$'
        ).hasMatch(row.value);
      },
    ),
    TFormRow.input(
      title: "验证码",
      placeholder: "请输入验证码",
      keyboardType: TextInputType.phone,
      suffixWidget: (context, row) {
        print('TFormRow.input suffixWidget');
        return VerifitionCodeButton(
          '获取验证码',
          onPressed: () {
            ToastUtil.showToast('验证码已发送', context: context);
          },
        );
      },
    ),
    TFormRow.input(
      title: "* 密码",
      value: "123456",
      obscureText: true,
      state: false,
      placeholder: "请输入密码",
      suffixWidget: (context, row) {
        return GestureDetector(
          onTap: () {
            row.state = !row.state;
            row.obscureText = !row.obscureText;
            TForm.of(context).reload();
          },
          child: Image.asset(
            row.state ? "images/eyes_open.png" : "images/eyes_close.png",
            width: ScreenUtil().setWidth(16),
            height: ScreenUtil().setHeight(16),
          ),
        );
      },
    ),
    TFormRow.customSelector(
      title: '城市',
      placeholder: '请选择',
      require: false,
      onTap: (context, row) async {
        return showCityPicker(context);
      },
    ),
    TFormRow.customSelector(
      title: "婚姻状况",
      placeholder: "请选择",
      require: false,
      state: [
        ["未婚", "已婚"],
        [
          TFormRow.input(
              title: "配偶姓名", placeholder: "请输入配偶姓名", requireStar: true),
          TFormRow.input(
              title: "配偶电话", placeholder: "请输入配偶电话", requireStar: true)
        ]
      ],
      onTap: (context, row) async {
        String value = await showPicker(context, row.state[0]);
        if (row.value != value) {
          if (value == "已婚") {
            TForm.of(context).insert(row, row.state[1]);
          } else {
            TForm.of(context).delete(row.state[1]);
          }
        }
        return value;
      },
    ),
    TFormRow.customSelector(
      title: '学历',
      placeholder: '请选择',
      require: false,
      onTap: (context, row) async {
        return showPicker(
            context,
            ["小学", "初中", "高中", "专科", "本科", "硕士及以上"],
            selecteds: [3]
        );
      },
    ),
    TFormRow.multipleSelector(
      title: '家庭成员',
      placeholder: '请选择',
      require: false,
      options: [
        TFormOptionModel(value: "父亲", selected: true),
        TFormOptionModel(value: "母亲", selected: false),
        TFormOptionModel(value: "儿子", selected: true),
        TFormOptionModel(value: "女儿", selected: false)
      ],
    ),
    TFormRow.customSelector(
      title: '出生年月',
      placeholder: '请选择',
      require: false,
      onTap: (context, row) {
        return showPickerDate(
          context,
          yearEnd: DateTime.now().year,
        );
      },
    ),
    TFormRow.customCellBuilder(
      tag: "1000",
      title: '描述照片',
      state: [
        {"picurl": ""},
        {"picurl": ""},
        {"picurl": ""},
      ],
      requireMsg: '完成上传房屋照片',
      validator: (row) {
        return (row.state as List)
            .every((element) => (element["picurl"].length > 0));
      },
      widgetBuilder: (context, row) {
        return CustomPhotosWidget(
            row: row
        );
      },
    ),
  ];

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
    print('_RegisterPageState build');
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(S.of(context).register),
        //backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            TForm.sliver(
              key: _formKey,
              rows: _formRows,
            ),
            SliverPadding(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(20)
                ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(20),
                    right: ScreenUtil().setWidth(20),
                ),
                child: SizedBox(
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
                    onPressed: _register,
                    child: Text(
                      S.of(context).immediately_register,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
    //FocusScope.of(context).unfocus();
    List errors = (_formKey.currentState as TFormState).validate();
    if (errors.isEmpty)
    {
      DialogUtil.showLoading(context);

      _registerViewModel
          .register(_accountController.text, _passWordController.text)
          .then((value) {
        if (value) {
          print('register true');

          var values = List<String>.empty(growable: true);
          for (var element in _formRows) {
            if (element.value == null && element.tag == "1000") {
              values.add('${element.title}: ');
              for (var element in (element.state as List)) {
                values.add('${element['picurl']}');
              }
            } else {
              values.add('${element.title}: ${element.value}');
            }
          }
          ToastUtil.showToast(values.join("\r\n"), context: context);
          //ToastUtil.showToast(S.of(context).register_success, context: context);
        } else {
          print('register false');
        }
      }, onError: (e) {
        ToastUtil.showToast(e.toString(), context: context);
      }).whenComplete(() => Navigator.pop(context));
    } else {
      ToastUtil.showToast(errors.first, context: context);
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
