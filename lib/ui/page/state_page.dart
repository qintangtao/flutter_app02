import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app02/generated/l10n.dart';


class PageState {

  PageState(this.code);

  final int code;

  static const int Success=0;
  static const int Empty=1;
  static const int Error=2;
}

typedef BuildError = Widget Function(BuildContext context);
typedef BuildEmpty = Widget Function(BuildContext context);
typedef BuildSuccess = Widget Function(BuildContext context);

class StatePage extends StatefulWidget {
  StatePage({Key? key, required this.build, this.buildError, this.buildEmpty}) : super(key: key);

  final BuildError? buildError;
  final BuildEmpty? buildEmpty;
  final BuildSuccess build;

  PageState state = PageState(PageState.Success);

  @override
  State<StatePage> createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch(widget.state.code) {
      case PageState.Success:
        return widget.build(context);
      case PageState.Empty:
        //return widget.buildError!(context) ?? const Text('error');
        return widget.buildError?.call(context) ?? const Text('error');
      case PageState.Error:
        //return widget.buildEmpty!(context) ?? const Text('empty');
        return widget.buildEmpty?.call(context) ?? const Text('empty');
    }
    return const Text("401");
  }
}