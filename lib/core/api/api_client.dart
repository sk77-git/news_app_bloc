import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app_bloc/core/api/http_client.dart';

class ApiClient {
  static const String baseUrl = "https://newsapi.org/v2";
  static final Dio _dio = HttpClient.client;

  /// Generic HTTP call method
  /// [method] defaults to GET
  static Future<Result<T>> call<T>({
    required String endpoint,
    Method method = Method.get,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    required T Function(dynamic json) parser,
  }) async {
    final url = baseUrl + endpoint;
    try {
      Response response;

      switch (method) {
        case Method.post:
          response = await _dio.post(
            url,
            data: body,
            queryParameters: queryParameters,
          );
          break;
        case Method.put:
          response = await _dio.put(
            url,
            data: body,
            queryParameters: queryParameters,
          );
          break;
        case Method.delete:
          response = await _dio.delete(
            url,
            data: body,
            queryParameters: queryParameters,
          );
          break;
        case Method.get:
          response = await _dio.get(url, queryParameters: queryParameters);
      }

      return Result.success(parser(response.data));
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }
}

class Result<T> {
  final Status status;
  final T? data;
  final Exception? exception;

  const Result._({required this.status, this.data, this.exception});

  factory Result.loading() => const Result._(status: Status.loading);

  factory Result.success(T data) =>
      Result._(status: Status.success, data: data);

  factory Result.error(Exception exception) =>
      Result._(status: Status.error, exception: exception);

  bool get isLoading => status == Status.loading;

  bool get isSuccess => status == Status.success;

  bool get isError => status == Status.error;
}

enum Status { none, loading, error, success }

enum Method { get, post, put, delete }

List<T> parseList<T>(
  dynamic jsonList,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (jsonList == null || jsonList is! List || jsonList.isEmpty) {
    return [];
  }
  return jsonList
      .map((json) => fromJson(json as Map<String, dynamic>))
      .toList();
}

extension ExceptionMessage on Exception {
  String get customMessage {
    if (this is DioException) {
      return _handleDioError(this as DioException);
    } else if (this is FormatException) {
      return "Invalid data format!";
    } else if (this is TimeoutException) {
      return "Request timed out. Please try again.";
    } else if (this is CustomException) {
      return (this as CustomException).message;
    } else {
      return "An unexpected error occurred.";
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionError:
        return "No internet connection!";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please check your network.";
      case DioExceptionType.sendTimeout:
        return "Request send timeout. Try again.";
      case DioExceptionType.receiveTimeout:
        return "Response timeout. Try again.";
      case DioExceptionType.badResponse:
        final data = error.response?.data;
        if (data is Map && data.containsKey("message")) {
          return data["message"].toString();
        } else if (data is String) {
          // If backend returns HTML or plain error
          if (data.contains("<html") || data.length > 100) {
            return "Server error occurred.";
          }
          return data;
        } else {
          return "Unexpected server response.";
        }
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      default:
        return "An unknown API error occurred.";
    }
  }
}

abstract class CustomException implements Exception {
  String get message;
}

class NoDataException implements CustomException {
  @override
  final String message;

  NoDataException(this.message);
}
