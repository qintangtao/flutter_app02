import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/base/base_view.dart';
import 'package:flutter_app02/base/base_view_state.dart';
import 'package:flutter_app02/base/base_smart_refresher.dart';
import 'package:flutter_app02/viewmodel/category_view_model.dart';
import 'package:flutter_app02/net/result.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh(CategoryViewModel model, {bool loading = false}) {
    model.refreshArticleListByCid(loading:loading);
  }

  void _onLoading(CategoryViewModel model) {
    model.loadMoreArticleList();
  }

  @override
  void initState() {
    super.initState();
    debugPrint("_MinePageState.initState");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("_MinePageState.build");
    return  BaseView<CategoryViewModel>(
      model: CategoryViewModel(),
      builder: (context, model, child) {
        return BaseViewState<CategoryViewModel>(
          model: model,
          builder: (context, model) => _buildBody(context, model),
          onTab: (model) =>  _onRefresh(model, loading: true),
          onCompleted: (model) => _stopRefreshOrLoadMore(_refreshController, model),
          onResult: (model, msg) {
            debugPrint("onResult -> code:${msg.code} msg:${msg.msg}");
          },
        );
      },
      onReady: (model) => _onRefresh(model, loading: true),
    );
  }


  Widget _buildBody(BuildContext context, CategoryViewModel model) {
    return BaseSmartRefresher(
      controller: _refreshController,
      onRefresh: () => _onRefresh(model),
      onLoading: () => _onLoading(model),
      child: _buildList(context, model),
    );
  }

  Widget _buildList(BuildContext context, CategoryViewModel model) {
    return ListView.builder(
      itemCount: model.items.length,
      itemBuilder: (context, index) {
        debugPrint("ListListenableBuilder build ${index}");
        return _buildListItem(context, model, index);
      },
    );
  }

  Widget _buildListItem(BuildContext context, CategoryViewModel model, int index) {
    return ListTile(
      title: Text(model.items[index].title),
      subtitle: Text(model.items[index].shareUser),
    );
  }

  void _stopRefreshOrLoadMore(RefreshController refreshController, CategoryViewModel model) {
    //debugPrint("stopRefreshOrLoadMore RESULT:${viewModel.resultCode} isRefresh:${refreshController.isRefresh} isLoading:${refreshController.isLoading}");
    if (model.resultCode == RESULT.end().code) {
      refreshController.loadNoData();
    } else if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    } else if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}