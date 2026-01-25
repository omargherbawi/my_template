import 'package:dio/dio.dart';
import '../../../../global_imports.dart';
import '../endpoints/character_endpoints.dart';
import '../model/character_model.dart';

abstract class CharacterDataSource {
  Future<CharacterResponseModel> getCharacters({int page = 1});
  Future<CharacterModel> getCharacter(int id);
}

class CharacterRemoteDataSource extends CharacterDataSource {
  final Dio _dio;

  CharacterRemoteDataSource({required Dio dio}) : _dio = dio {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: CharacterEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  @override
  Future<CharacterResponseModel> getCharacters({int page = 1}) async {
    final response = await _dio.get(
      CharacterEndpoints.getCharacters,
      queryParameters: {'page': page},
    );
    
    return CharacterResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    final response = await _dio.get('${CharacterEndpoints.getCharacter}/$id');
    
    return CharacterModel.fromJson(response.data as Map<String, dynamic>);
  }
}