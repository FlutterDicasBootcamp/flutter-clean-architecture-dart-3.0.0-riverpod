import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/errors/api_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/models/remote/api_response_model.dart';

abstract interface class ApiService {
  Future<Either<ApiException, ApiResponseModel>> get(String endPoint);
}
