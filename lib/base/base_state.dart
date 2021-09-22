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
  void onLoadResult(int code) {
    if (code == RESULT.end().code) {
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
    super.dispose();
  }

  void _registerListenable() {
    viewModel.startListenable.addListener(_onLoadStart);
    viewModel.errorListenable.addListener(_onLoadError);
    viewModel.completeListenable.addListener(_onLoadResult);
    viewModel.completeListenable.addListener(_onLoadCompleted);
  }

  void _unregisterListenable() {
    viewModel.startListenable.removeListener(_onLoadStart);
    viewModel.errorListenable.removeListener(_onLoadError);
    viewModel.completeListenable.removeListener(_onLoadResult);
    viewModel.completeListenable.removeListener(_onLoadCompleted);
  }

  void _onLoadStart() { onLoadStart(); }
  void _onLoadError() { onLoadError(viewModel.errorListenable.value); }
  void _onLoadResult() { onLoadResult(viewModel.resultListenable.value); }
  void _onLoadCompleted() { onLoadCompleted(); }

  @override
  Widget build(BuildContext context) {
    debugPrint("BaseState.build");
    return buildChangeNotifierProvider(context);
  }

  Widget buildChangeNotifierProvider(BuildContext context) {
    return ChangeNotifierProvider<VM>(
      create: (_) => viewModel,
      child: Consumer<VM>(
        builder: (builder, model, child) {
          return buildPage(model);
        },
      ),
    );
  }

  Widget buildPage(VM model) {
    //stopRefreshOrLoadMore(_refreshController);
    if (model.pageState == PageState.success) {
      return buildSuccessPage(model);
    } else if (model.pageState == PageState.loading) {
      return buildLoadingPage(model);
    } else if (model.pageState == PageState.empty) {
      return buildEmptyPage(model);
    } else {
      return buildErrorPage(model);
    }
  }


  Widget buildSuccessPage(VM model);
  /*
  Widget buildSuccessPage(VM model) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus? mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  const Text("pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  const CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = const Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = const Text("release to load more");
          }
          else{
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (context, index) {
          debugPrint("ListListenableBuilder build ${index}");
          return ListTile(
            title: Text(model.items[index].title),
            subtitle: Text(model.items[index].shareUser),
          );
        },
      ),
    );
  }*/

  Widget buildLoadingPage(VM model) {
    return const Center(
      child: LoadingDialog(),
    );
  }
  Widget buildEmptyPage(VM model) {
    return Center(
      child: GestureDetector(
        child: Text('empty', style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),),
        onTap: lazyLoadData,
      ),
    );
  }
  Widget buildErrorPage(VM model) {
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
}