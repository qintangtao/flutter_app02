import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app02/util/http_util.dart';
import '../base/base_result.dart';
import 'package:flutter_app02/model/pagination.dart';
import 'package:flutter_app02/model/article.dart';

class WanApi {

  static WanApi? _api;
  factory WanApi() => _getInstance();
  static WanApi get instance => _getInstance();

  static WanApi _getInstance() {
      _api ??= WanApi._internal();
    return _api!;
  }

  WanApi._internal() {
    _httpUtil = HttpUtil(baseUrl: "https://www.wanandroid.com/");
  }

  late HttpUtil _httpUtil;

  Future<BaseResult<Pagination<Article>>> getArticleListByCid(int page, int cid) async {
    debugPrint("getArticleListByCid ${page} ${cid}");
    var response = await _httpUtil.get(
        "/article/list/${page}/json",
        queryParameters: {"cid": cid});
    debugPrint(response.realUri.path);
    //debugPrint(response.data);
    var result = BaseResult<Pagination<Article>>.fromJson(response.data);
    if (response.data.containsKey('data')) {
      result.data = Pagination<Article>.fromJson(response.data['data']);
      if (response.data['data'].containsKey('datas')) {
        result.data.datas = (response.data['data']['datas'] as List).map((e) => Article.fromJson(e)).toList();
      }
    }

    return result;
  }

/*
  Future<Map<String, dynamic>> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {

    try {
      var response = await _httpUtil.get(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);

      var result = BaseResult<Map<String, dynamic>>(response.data);
      if (result.isSuccess){
        return result.data!;
      }
      throw ResponseException.result(result);
    //} on DioError catch (e) {
   //  //debugPrint("HttpUtil.get DioError ${e}");
   //   throw ExceptionHandle.handleException(e);
    } catch(e) {
      debugPrint("WanApi.get ${e}");
      throw ExceptionHandle.handleException(e);
    }

  }
*/


}