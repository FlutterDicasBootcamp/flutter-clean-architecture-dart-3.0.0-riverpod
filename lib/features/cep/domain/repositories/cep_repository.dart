import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/cep_response.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';

abstract interface class CepRepository {
  Future<Either<CepException, CepResponseModel?>> getCepDetailsByCep(
      GetCepDetailsByCepBody cep);

  Future<Either<CepException, List<CepResponse>?>> getCepDetailsByLocalDetails(
      GetCepDetailsByLocalDetailsBody cep);
}
