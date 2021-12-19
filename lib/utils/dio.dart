import 'package:dio/dio.dart';

class Call {
  static Dio? _dio;

  //单例初始化配置
  static BaseOptions _options = new BaseOptions(
    receiveTimeout: 5000,
    sendTimeout: 4000,
    connectTimeout: 10000,
    contentType: Headers.jsonContentType,
  );

  //实例化
  static Dio? buildDio() {
    if (_dio == null) {
      _dio = new Dio(_options);
    }
    return _dio;
  }

  //调用方法
  static dispatch(
    url, {
    bool loading = false,
    Map<String, dynamic>? data,
    String? options,
    int? timeout,
    bool forceRefresh = true,
    bool isfilter = false,
    isGetData = false,
  }) async {
    Map<String, dynamic> parameter = data ?? {};
    String method = options ?? "GET";
    // String token = Storage.token.value ?? '';
    _options.baseUrl = 'https://api.xiuxf.xyz';
    _options.headers = {
      'content-type': "application/json; charset=utf-8",
    };

    Dio? dio = buildDio();
    Response response;
    // dio.interceptors.add(LogInterceptor(error: true)); // 打印头或主体信息，调试用
    dio?.options.connectTimeout = timeout ?? 10000;

    try {
      //请求
      // if (isGetData) {
      //   response = await dio!.request(
      //     url,
      //     queryParameters: parameter,
      //     options: Options(
      //       method: method,
      //     ),
      //   );
      // } else {
      response = await dio!.request(
        url,
        data: parameter,
        options: Options(
          method: method,
        ),
      );
      // }

      return response.data;
    } on DioError catch (e) {
      var error = formatError(e);
      return {'code': -998, 'msg': error, 'data': ''};
    }
  }
}

formatError(DioError e) {
  var item = 'Network Error';
  if (e.type == DioErrorType.connectTimeout) {
    item = '连接超时';
    print("连接超时");
  } else if (e.type == DioErrorType.sendTimeout) {
    item = '请求超时';
    print("请求超时");
  } else if (e.type == DioErrorType.receiveTimeout) {
    item = '响应超时';
    print("响应超时");
  } else if (e.type == DioErrorType.response) {
    item = '出现异常';
    print("出现异常");
  } else if (e.type == DioErrorType.cancel) {
    item = '请求取消';
    print("请求取消");
  } else if (e.type == DioErrorType.other) {
    item = '服务器开小差了~~';
  } else {
    item = '未知错误';
    print("未知错误");
  }
  return item;
}
