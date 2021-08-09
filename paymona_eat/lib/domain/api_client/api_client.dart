import 'dart:convert';
import 'dart:io';

import 'package:dart_lesson/domain/entity/eat_details.dart';
import 'package:dart_lesson/domain/entity/popular_eat_res.dart';

enum ApiClientExceptionType { Network, Auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();
  static const _host = 'http://103.246.146.95:7005/';
  static const api_key =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTYyNzc0MDY0NiwianRpIjoiMGI2OTMwMDMtOGFlNi00MzQ1LWJjOWYtZTcxNTU3ZjMxNzI4IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImFkbWluIiwibmJmIjoxNjI3NzQwNjQ2LCJleHAiOjE2Mjc3NDE1NDZ9.sfK5liqeUgzwOaNd3CIzlp8KMWI5KZhI-ekW4NaOcBw';
  // static const _imageUrl = 'https://image.tmdb.org/t/p/w500';

  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final validToken = await _validateUser(
      username: username,
      password: password,
    );

    return validToken;
  }

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<T> _get<T>(
    String path,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? parameters,
  ]) async {
    final url = _makeUri(path, parameters);
    try {
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  // ignore: unused_element
  Future<T> _post<T>(
    String path,
    Map<String, dynamic> bodyParameters,
    T Function(dynamic json) parser, [
    Map<String, dynamic>? urlParameters,
  ]) async {
    try {
      final url = _makeUri(path, urlParameters);
      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(bodyParameters));
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      _validateResponse(response, json);

      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<PopularEatRes> popularEat(int page) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularEatRes.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      'main_slider/get',
      parser,
      <String, dynamic>{
        // 'api_key': api_key,
        'page': page.toString(),
      },
    );
    return result;
  }

// Чтобы загрузить каждый товар
  Future<EatDetails> eatDetails(int eatId) async {
    final parser = (dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = EatDetails.fromJson(jsonMap);
      return response;
    };
    final result = _get(
      'main_slider/get/$eatId',
      parser,
      <String, dynamic>{
        'api_key': api_key,
        // 'page': eatId.toString(),
      },
    );
    return result;
  }

  //Для проверки валидации кода
  Future<String> _validateUser({
    required String username,
    required String password,
  }) async {
    final url = _makeUri(
      'login/',
    );
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
    };
    try {
      final request = await _client.postUrl(url);

      request.headers.contentType = ContentType.json;
      request.write(jsonEncode(parameters));
      final response = await request.close();
      if (response.statusCode == 401) {
        throw ApiClientException(ApiClientExceptionType.other);
      }
      final json = (await response.jsonDecode()) as Map<String, dynamic>;

      final token = json['access_token'] as String;
      return token;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.Auth);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
    // _client.connectionTimeout = Duration.zero;
  }
}

void _validateResponse(HttpClientResponse response, dynamic json) {
  if (response.statusCode == 401) {
    final dynamic status = json['status_code'];
    final code = status is int ? status : 0;
    if (code == 30) {
      throw ApiClientException(ApiClientExceptionType.Auth);
    } else {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((value) {
      final result = value.join();
      return result;
    }).then<dynamic>((v) => json.decode(v));
  }
}
