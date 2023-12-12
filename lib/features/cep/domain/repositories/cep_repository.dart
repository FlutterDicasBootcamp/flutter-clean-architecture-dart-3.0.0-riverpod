import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/errors/get_cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';

abstract interface class CepRepository {
  Future<Either<GetCepException, CepResponseModel?>> call(CepBodyModel cep);
}
