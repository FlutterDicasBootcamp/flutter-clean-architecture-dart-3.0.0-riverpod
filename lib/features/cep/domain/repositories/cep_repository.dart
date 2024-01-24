import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';

abstract interface class CepRepository {
  Future<Either<CepException, CepResponseModel?>> getCepDetailsByCep(
      CepBody cep);
}
