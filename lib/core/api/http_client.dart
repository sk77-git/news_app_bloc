import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

/// This class uses the dio library to connect to the internet for data communication
class HttpClient {
  static final client = Dio()
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        try {
          log('Request:[${options.method}] ${options.uri}\nHeaders:${options.headers}\nBody:${jsonEncode(options.data)}');
        } catch (e) {
          log(e.toString());
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        try {
          log('Response:[${response.statusCode}] ${response.realUri}\nBody:${jsonEncode(response.data ?? {})}');
        } catch (e) {
          log(e.toString());
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        try {
          log('Response:[${e.response?.statusCode}] ${e.response?.realUri}\nBody:${jsonEncode(e.response?.data ?? {})}');
        } catch (e) {
          log(e.toString());
        }
        return handler.next(e);
      },
    ));
}
