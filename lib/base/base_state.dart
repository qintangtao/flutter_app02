import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'base_view_model.dart';
import 'package:flutter_app02/ui/widgets/loading_dialog.dart';
import 'package:flutter_app02/base/page_state.dart';
import 'package:flutter_app02/net/message.dart';
import 'package:flutter_app02/util/toast_util.dart';
import 'package:flutter_app02/net/result.dart';

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel> extends State<T> {

  late VM viewModel;

  VM createViewModel();
  void lazyLoadData();

  void onLoadStart() {}
  void onLoadError(Message msg) {}
  void onLoadResult(Message msg) {
    if (msg.code == RESULT.end().code) {
      ToastUtil.showToast(RESULT.end().msg, context: context);
    }
  }
  void onLoadCompleted() {}

  @override
  void initState() {
    super.initState();
    viewModel = createViewModel();
    _registerListenable();
    lazyLoadData();
  }

  @override
  void dispose() {
    _unregisterListenable();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("BaseState.build");
    return buildChangeNotifierProvider(context);
  }

  Widget buildChangeNotifierProvider(BuildContext context) {
    return ChangeNotifierProvider<VM>(
      create: (_) => viewModel,
      child: Consumer<VM>(
        builder: (context, model, child) {
          return buildPage(context, model);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context, VM model) {
    if (model.state == PageState.success) {
      return buildSuccessPage(context, model);
    } else if (model.state == PageState.loading) {
      return buildLoadingPage(context, model);
    } else if (model.state == PageState.empty) {
      return buildEmptyPage(context, model);
    } else {
      return buildErrorPage(context, model);
    }
  }

  Widget buildSuccessPage(BuildContext context, VM model);

  Widget buildLoadingPage(BuildContext context, VM model) {
    return const Center(
      child: LoadingDialog(),
    );
  }
  Widget buildEmptyPage(BuildContext context, VM model) {
    return Center(
      child: GestureDetector(
        child: Text('empty', style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),),
        onTap: lazyLoadData,
      ),
    );
  }
  Widget buildErrorPage(BuildContext context, VM model) {
    return Center(
      child: GestureDetector(
        child: Text("${model.errorCode} ${model.errorMsg}",
          style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor),
        ),
        onTap: lazyLoadData,
      ),
    );
  }

  void stopRefreshOrLoadMore(RefreshController refreshController) {
    debugPrint("stopRefreshOrLoadMore RESULT:${viewModel.resultCode} isRefresh:${refreshController.isRefresh} isLoading:${refreshController.isLoading}");
    //if (viewModel.resultCode == RESULT.end().code) {
    //  refreshController.loadNoData();
    //} else
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    } else if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
  }

  void _registerListenable() {
    viewModel.startListenable.addListener(_onLoadStart);
    viewModel.errorListenable.addListener(_onLoadError);
    viewModel.resultListenable.addListener(_onLoadResult);
    viewModel.completeListenable.addListener(_onLoadCompleted);
  }

  void _unregisterListenable() {
    viewModel.startListenable.removeListener(_onLoadStart);
    viewModel.errorListenable.removeListener(_onLoadError);
    viewModel.resultListenable.removeListener(_onLoadResult);
    viewModel.completeListenable.removeListener(_onLoadCompleted);
  }

  void _onLoadStart() { onLoadStart(); }
  void _onLoadError() { onLoadError(viewModel.errorListenable.value); }
  void _onLoadResult() { onLoadResult(viewModel.resultListenable.value); }
  void _onLoadCompleted() { onLoadCompleted(); }
}