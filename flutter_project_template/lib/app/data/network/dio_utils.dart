import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'error_handle.dart';

// 单例
class DioUtils {
  static DioUtils instance = DioUtils.internal();
  factory DioUtils() => instance;

  late Dio dio;

  DioUtils.internal() {
    /// BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = BaseOptions(
      ///连接服务器超时时间，单位是毫秒.
      connectTimeout: 30 * 1000,

      /// 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 60 * 1000,
    );

    dio = Dio(options);

    /// Cookie管理
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    /// 开启请求日志
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future request(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? sendProgress,
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      /// 没有网络
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        throw _onError(ExceptionHandle.net_error, '网络异常，请检查你的网络！');
      }

      return await dio.request(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: sendProgress);
    } on DioError catch (e) {
      /// 抛出NetError
      final NetError netError = ExceptionHandle.handleException(e);
      throw _onError(netError.code, netError.msg);
    }
  }
}

_onError(int? code, String msg) {
  if (code == null) {
    code = ExceptionHandle.unknown_error;
    msg = '未知异常';
  }
  return NetError(code, msg);
}
