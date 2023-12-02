import 'package:dio/dio.dart';
import 'package:marvel_animations/models/authentication_params.dart';
import 'package:marvel_animations/models/character.dart';
import 'package:marvel_animations/utils/api_secrets.dart';

class MarvelService {
  MarvelService() {
    _dio = Dio();
    AuthenticationParams params =
        AuthenticationParams(publicKey: publicKey, privateKey: privateKey);
    _dio.options.baseUrl = 'https://gateway.marvel.com/v1/public';
    _dio.options.queryParameters = {
      'apikey': params.publicKey,
      'ts': params.ts,
      'hash': params.hash
    };
  }

  late Dio _dio;

  Future<List<Character>> getCharacters({Map<String, dynamic>? args}) async {
    final Response response =
        await _dio.get('/characters', queryParameters: args);
    final List<dynamic> results = response.data['data']['results'];
    return results.map((dynamic json) => Character.fromJson(json)).toList();
  }

  Future<Character> getCharacter(int id) async {
    final Response response = await _dio.get('/characters/$id');
    return Character.fromJson(response.data);
  }
}
