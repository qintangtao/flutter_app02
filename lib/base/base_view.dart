import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app02/base/base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {

  const BaseView({
    Key? key,
    required this.model,
    required this.builder,
    this.onReady,
    this.child}) : super(key: key);

  final T model;
  final Widget? child;

  final Widget Function(
      BuildContext context,
      T value,
      Widget? child,
      ) builder;

  final Function(T)? onReady;

  @override
  State<StatefulWidget> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {

  @override
  void initState() {
    widget.onReady!(widget.model);
    super.initState();
  }

  @override
  void dispose() {
    widget.model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
      create: (BuildContext context) => widget.model,
    );
  }


}