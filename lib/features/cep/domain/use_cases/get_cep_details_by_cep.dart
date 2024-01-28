import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';

class GetCepDetailsByCep {
  final CepRepository _cepRepo;

  GetCepDetailsByCep(this._cepRepo);

  Future<Either<CepException, CepResponseModel?>> call(
      GetCepDetailsByCepBody cep) {
    return _cepRepo.getCepDetailsByCep(cep);
  }
}
