import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app02/base/base_view_model.dart';
import 'package:flutter_app02/base/page_state.dart';
import 'package:flutter_app02/net/message.dart';

class BaseViewState<T extends BaseViewModel> extends StatefulWidget {

  const BaseViewState({Key? key,
    required this.model,
    required this.builder,
    this.loadingBuilder,
    this.emptyBuilder,
    this.errorBuilder,
    this.onTab,
    this.onStart,
    this.onError,
    this.onResult,
    this.onCompleted,
    this.child}) : super(key: key);

  final T model;
  final Widget? child;

  final Widget Function(
      BuildContext context,
      T value,
      ) builder;

  final Widget Function(
      BuildContext context,
      T value,
      )? loadingBuilder;

  final Widget Function(
      BuildContext context,
      T value,
      )? emptyBuilder;

  final Widget Function(
      BuildContext context,
      T value,
      )? errorBuilder;


  final Function(T)? onTab;

  final Function(T)? onStart;
  final Function(T, Message)? onError;
  final Function(T, int)? onResult;
  final Function(T)? onCompleted;

  @override
  State<StatefulWidget> createState() => _BaseViewStateState<T>();
}

class _BaseViewStateState<T extends BaseViewModel> extends State<BaseViewState<T>> {

  late T model;

  @override
  void initState() {
    model = widget.model;
    _registerListenable();
    super.initState();
  }

  @override
  void dispose() {
    _unregisterListenable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (model.state == PageState.success) {
      return widget.builder(context, model);
    } else if (model.state == PageState.loading) {
      return widget.loadingBuilder?.call(context, model) ?? _buildLoading(context, model);
    } else if (model.state == PageState.empty) {
      return widget.emptyBuilder?.call(context, model) ?? _buildEmpty(context, model);
    } else {
      return widget.errorBuilder?.call(context, model) ?? _buildError(context, model);
    }
  }

  Widget _buildLoading(BuildContext context, T model) {
    return const Center(
      child: CupertinoActivityIndicator(
        animating: true,
        radius: 20,
      ),
    );
  }

  Widget _buildEmpty(BuildContext context, T model) {
    return Center(
      child: GestureDetector(
        child: Text('empty', style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),),
        onTap: widget.onTab!(model),
      ),
    );
  }

  Widget _buildError(BuildContext context, T model) {
    return Center(
      child: GestureDetector(
        child: Text("${model.errorCode} ${model.errorMsg}",
          style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor),
        ),
        onTap: widget.onTab!(model),
      ),
    );
  }

  void _registerListenable() {
    model.startListenable.addListener(_onLoadStart);
    model.errorListenable.addListener(_onLoadError);
    model.resultListenable.addListener(_onLoadResult);
    model.completeListenable.addListener(_onLoadCompleted);
  }

  void _unregisterListenable() {
    model.startListenable.removeListener(_onLoadStart);
    model.errorListenable.removeListener(_onLoadError);
    model.resultListenable.removeListener(_onLoadResult);
    model.completeListenable.removeListener(_onLoadCompleted);
  }

  void _onLoadStart() { widget.onStart!(model); }
  void _onLoadError() { widget.onError!(model, model.errorListenable.value); }
  void _onLoadResult() { widget.onResult!(model, model.resultListenable.value);  }
  void _onLoadCompleted() { widget.onCompleted!(model); }
}