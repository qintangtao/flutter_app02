import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/viewmodel/home_view_model.dart';
import 'package:flutter_app02/base/page_state.dart';
import 'package:flutter_app02/ui/widgets/loading_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin {

  final HomeViewModel _viewModel = HomeViewModel();

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh({bool loading = false}) {
    _viewModel.refreshArticleListByCid(loading:loading);
    //_refreshController.refreshCompleted();
  }

  void _onLoading() {
    _viewModel.loadMoreArticleList();
    //_refreshController.loadComplete();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("_HomePageState.initState");
    _onRefresh(loading: true);
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("_HomePageState.build");
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Consumer<HomeViewModel>(
          builder: (builder, model, child) {
            return buildPage(model);
          },
      ),
    );
  }

  void stopRefreshOrLoadMore(RefreshController refreshController) {
    if (refreshController.isRefresh) {
      refreshController.refreshCompleted();
    } else if (refreshController.isLoading) {
      refreshController.loadComplete();
    }
  }

  Widget buildPage(model) {
    stopRefreshOrLoadMore(_refreshController);
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

  Widget buildSuccessPage(model) {
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
  }
  Widget buildLoadingPage(model) {
    return const Center(
      child: LoadingDialog(),
    );
  }
  Widget buildEmptyPage(model) {
    return Center(
      child: GestureDetector(
        child: Text('empty', style: TextStyle(fontSize: 50, color: Theme.of(context).primaryColor),),
        onTap: _onRefresh,
      ),
    );
  }
  Widget buildErrorPage(model) {
    return Center(
      child: GestureDetector(
        child: Text("error",
          style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor),
        ),
        onTap: () => _onRefresh(loading: true),
      ),
    );
  }


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}