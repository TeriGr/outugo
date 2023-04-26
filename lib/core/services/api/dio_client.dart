import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:outugo_flutter_mobile/utils/constants/data_constants/api_constants.dart';

class DioClient {
  late Dio _dio;
  final String? baseUrl;
  final Connectivity connectivity;

  DioClient(
    Dio? dio, {
    this.baseUrl,
    required this.connectivity,
  }) {
    _dio = dio ?? Dio();
    _dio
      ..options = BaseOptions(
        baseUrl: baseUrl ?? kBaseUrl,
        connectTimeout: Duration(milliseconds: 50000),
        receiveTimeout: Duration(milliseconds: 50000),
        followRedirects: false,
        // will not throw errors
        // followRedirects: false,
        // validateStatus: (status) {
        //   return status != null ? status < 500 : false;
        // },
      )
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      };

    log('DioClient: ${_dio.options.baseUrl}');
    // if (kDebugMode) {
    //   _dio.interceptors.add(LogInterceptor(
    //       responseBody: true,
    //       error: true,
    //       requestHeader: false,
    //       responseHeader: false,
    //       request: false,
    //       requestBody: false));
    // }
  }

  updateBaseUrl(String newUri) {
    _dio.options.baseUrl = newUri;
  }

  hasHeaders({bool has = true}) {
    if (has) {
      _dio.options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      };
    } else {
      _dio.options.headers = {};
    }
  }

  Future addAuthorizationInterceptor() async {
    final token = GetStorage().read('token');

    print('token: $token');
    if (token != null) {
      _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        // options.headers['Authorization'] = token;

        // add the access token to the body too.

        try {
          options.headers['Authorization'] = 'Bearer $token';
        } catch (e) {
          print('$e');
        }

        return handler.next(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      }));
    }
  }

  // Future addIsFileInterceptor() async {
  //   _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
  //     // Do something before request is sent
  //     // options.headers['Authorization'] = token;

  //     // add the access token to the body too.

  //     try {
  //       options.headers['Content-Type'] = 'multipart/form-data';
  //     } catch (e) {
  //       print('$e');
  //     }

  //     return handler.next(options); //continue
  //     // If you want to resolve the request with some custom data，
  //     // you can resolve a `Response` object eg: return `dio.resolve(response)`.
  //     // If you want to reject the request with a error message,
  //     // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  //   }, onResponse: (response, handler) {
  //     // Do something with response data
  //     return handler.next(response); // continue
  //     // If you want to reject the request with a error message,
  //     // you can reject a `DioError` object eg: return `dio.reject(dioError)`
  //   }, onError: (DioError e, handler) {
  //     // Do something with response error
  //     return handler.next(e); //continue
  //     // If you want to resolve the request with some custom data，
  //     // you can resolve a `Response` object eg: return `dio.resolve(response)`.
  //   }));
  // }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    log("message: get $uri");
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      print(response);
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postMultipart(
    String url,
    File body,
    String name,
  ) async {
    try {
      var fileName =
          "file$name-${DateTime.now().second}-${DateTime.now().millisecond}.jpg";

      var file = MultipartFile.fromFileSync(body.path,
          filename: fileName, contentType: MediaType('multipart', 'form-data'));

      var formData = FormData();
      formData.files.add(MapEntry("image", file));

      final response = await _dio.post(
        url,
        data: formData,
      );
      log(response.data.toString());
      return response.data;
    } on TimeoutException catch (exception) {
      throw Exception('Request timeout');
    } on Exception catch (exception) {
      throw Exception('Exception: ' + exception.toString());
    } catch (error) {
      throw Exception('Error: ' + error.toString());
    }
  }
}
