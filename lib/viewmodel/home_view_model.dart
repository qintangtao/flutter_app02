import 'package:flutter_app02/generated/l10n.dart';
import 'package:flutter_app02/model/article.dart';
import 'package:flutter_app02/model/pagination.dart';
import 'package:flutter_app02/ui/widgets/list/list_notifier.dart';
import 'package:flutter_app02/net/wan_api.dart';
import 'package:flutter_app02/net/response_exception.dart';
import 'package:flutter_app02/net/error.dart';
import 'package:flutter_app02/net/result.dart';
import '../base/page_state.dart';
import '../base/base_view_model.dart';
import 'package:flutter_app02/net/message.dart';

class HomeViewModel extends BaseViewModel {

  //final items = ListNotifier<Article>([]);

  int curPage = 0;
  List<Article> items = [];

  void refreshArticleListByCid({bool loading = false}) {
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
      if (data.offset >= data.total) {
        return RESULT.end();
      } else {
        return RESULT.success();
      }
    });
  }

}