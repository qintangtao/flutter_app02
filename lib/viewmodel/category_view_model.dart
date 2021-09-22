import 'package:flutter/cupertino.dart';
import 'package:flutter_app02/model/article.dart';
import 'package:flutter_app02/model/pagination.dart';
import 'package:flutter_app02/net/wan_api.dart';
import 'package:flutter_app02/net/result.dart';
import '../base/base_view_model.dart';

class CategoryViewModel extends BaseViewModel {

  //final items = ListNotifier<Article>([]);

  int curPage = 0;
  List<Article> items = [];

  void refreshArticleListByCid({bool loading = false}) {
    debugPrint("refreshArticleListByCid ${loading}");
    launchOnlyResult<Pagination<Article>>(() {
      return WanApi().getArticleListByCid(0, 0);
    }, (data) {
      if (data.datas.isNotEmpty) {
        curPage = data.curPage;
        items = data.datas;
        return RESULT.success();
      }
      return RESULT.empty();
    },
    loading: loading);
  }


  void loadMoreArticleList() {
    launchOnlyResult<Pagination<Article>>(() {
      return WanApi().getArticleListByCid(curPage, 0);
    }, (data) {
      curPage = data.curPage;
      items.addAll(data.datas);
      debugPrint("loadMoreArticleList offset:${data.offset} size:${data.size} pageCount:${data.pageCount} total:${data.total} curPage:${data.curPage}");
      if (curPage >= 3) {
        return RESULT.end();
      }
      if (data.offset >= data.total) {
        return RESULT.end();
      } else {
        return RESULT.success();
      }
    });
  }

}