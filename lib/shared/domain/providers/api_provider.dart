import 'package:dio/dio.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/dio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiProvider = Provider<ApiService>(
  (ref) => DioService(
    Dio(
      BaseOptions(
        baseUrl: 'https://viacep.com.br/ws/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    ),
  ),
);
