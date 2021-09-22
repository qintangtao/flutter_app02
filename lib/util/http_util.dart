import 'package:dio/dio.dart';
//import 'package:dio_http2_adapter/dio_http2_adapter.dart';

class HttpUtil {

  static HttpUtil? _httpUtil;
  factory HttpUtil({String baseUrl = ''}) => _getInstance(baseUrl);
  static HttpUtil get instance => _getInstance('');

  static HttpUtil _getInstance(String baseUrl) {
    _httpUtil ??= HttpUtil._internal(baseUrl);
    return _httpUtil!;
  }

  late Dio _dio;

  HttpUtil._internal(String baseUrl) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));
    /*
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: 10000,
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    );
     */
  }

  Future<Response> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    return _dio.get(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }



}