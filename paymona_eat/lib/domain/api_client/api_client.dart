import 'dart:convert';
import 'dart:io';

class ApiClient {
  final _client = HttpClient();
  static const _host = 'http://103.246.146.95:7005/';
  // static const _imageUrl = 'https://image.tmdb.org/t/p/w500';
  // static const _apiKey = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTYyNzA0OTc2OCwianRpIjoiYzNlZmZmOGUtOGU4OC00NGQ2LWEyYjItMzhmZWQ2NWY2NDFiIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6ImFkbWluIiwibmJmIjoxNjI3MDQ5NzY4LCJleHAiOjE2MjcwNTA2Njh9.FdQwZ1ot2DfpQYgOS0cyZapApeOvIChWvTmbNdc7Z6I';

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
    final request = await _client.postUrl(url);

    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final json = (await response.jsonDecode()) as Map<String, dynamic>;

    final token = json['access_token'] as String;
    return token;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
