import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum HttpMethod { get, post, put }

sealed class Result<T> {
  const Result();

  factory Result.ok(T value) => Ok(value);

  factory Result.error(String message) => Error(message);
}

final class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

final class Error<T> extends Result<T> {
  const Error(this.message);

  final String message;
}

class NetworkService {
  NetworkService._privateConstructor();

  static final NetworkService _instance = NetworkService._privateConstructor();

  factory NetworkService() => _instance;

  Future<Result<T>> request<T>({
    required String url,
    required HttpMethod method,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      http.Response response;
      final requestHeaders = {
        'Content-Type': 'application/json',
        if (headers != null) ...headers,
      };

      switch (method) {
        case HttpMethod.get:
          final uri = Uri.parse(url).replace(queryParameters: parameters);
          response = await http
              .get(uri, headers: requestHeaders)
              .timeout(const Duration(seconds: 5));
          break;
        case HttpMethod.post:
          response = await http
              .post(
                Uri.parse(url),
                headers: requestHeaders,
                body: json.encode(parameters),
              )
              .timeout(const Duration(seconds: 5));
          break;
        case HttpMethod.put:
          response = await http
              .put(
                Uri.parse(url),
                headers: requestHeaders,
                body: json.encode(parameters),
              )
              .timeout(const Duration(seconds: 5));
          break;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          if (response.body.isEmpty || response.body.trim() == "null") {
            return Result.error("Empty or invalid response from server.");
          }

          final decoded = json.decode(response.body);

          // finalJson هو اللي هيتم تمريره للـ fromJson
          late Map<String, dynamic> finalJson;

          if (decoded is Map<String, dynamic>) {
            // لو الرد Map: عادي نبعته
            finalJson = decoded;
          } else if (decoded is List) {
            // لو الرد List: نغلفه في Map علشان fromJson يتعامل مع Map
            finalJson = {'data': decoded};
          } else {
            return Result.error(
                "Unexpected response format: neither Map nor List.");
          }

          final parsed = fromJson(finalJson);
          return Result.ok(parsed);
          // if (decoded is Map<String, dynamic>) {
          // final parsedJson = fromJson(decoded);
          // return Result.ok(parsedJson);
          // }

          // if ((decoded is List<dynamic>) ||
          //     (decoded is List<Map<String, dynamic>>)) {
          //   List<dynamic> listOfJson = json.decode(response.body);
          // listOfJson = List.from(decoded);
          // final parsedList = fromJson(listOfJson);
          // }
        } on FormatException {
          return Result.error('Error in data formatting.');
        }
      }

      final errorMessage = _parseErrorMessage(response.body);
      return Result.error(errorMessage);
    } on SocketException {
      return Result.error('No Internet Connection!');
    } on TimeoutException {
      return Result.error('Request Timeout');
    } catch (e) {
      return Result.error('Unexpected error: ${e.toString()}');
    }
  }

  Future<Result<List<T>>> requestList<T>({
    required String url,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json'
      }).timeout(const Duration(seconds: 5));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty || response.body.trim() == "null") {
          return Result.error("Empty response from server.");
        }

        final decoded = json.decode(response.body);

        if (decoded is List) {
          final list = decoded.map((item) => fromJson(item)).toList();
          return Result.ok(list);
        } else {
          return Result.error("Expected a JSON array");
        }
      }

      return Result.error(_parseErrorMessage(response.body));
    } on SocketException {
      return Result.error('No Internet Connection!');
    } on TimeoutException {
      return Result.error('Request Timeout');
    } catch (e) {
      return Result.error('Unexpected error: ${e.toString()}');
    }
  }

  String _parseErrorMessage(String body) {
    try {
      final jsonBody = json.decode(body);
      if (jsonBody is Map<String, dynamic>) {
        if (jsonBody.containsKey('message')) return jsonBody['message'];
        if (jsonBody.containsKey('error')) return jsonBody['error'];
        if (jsonBody.containsKey('detail')) return jsonBody['detail'];
      }
      if (jsonBody is List<dynamic>) {
        print("json of lists error");
      }
      return body;
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }
}
