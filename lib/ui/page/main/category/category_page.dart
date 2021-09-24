import 'package:flutter/material.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/base/base_state.dart';
import 'package:flutter_app02/viewmodel/category_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends BaseState<CategoryPage, CategoryViewModel> with AutomaticKeepAliveClientMixin {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh({bool loading = false}) {
    viewModel.refreshArticleListByCid(loading:loading);
  }

  void _onLoading() {
    viewModel.loadMoreArticleList();
  }

  @override
  CategoryViewModel createViewModel() => CategoryViewModel();

  @override
  void lazyLoadData() => _onRefresh(loading: true);

  @override
  void onLoadCompleted() => stopRefreshOrLoadMore(_refreshController);

  @override
  Widget build(BuildContext context) => buildChangeNotifierProvider(context);

  @override
  Widget buildSuccessPage(BuildContext context, CategoryViewModel model) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: const WaterDropHeader(),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
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
  }

  @override
  bool get wantKeepAlive => true;

}