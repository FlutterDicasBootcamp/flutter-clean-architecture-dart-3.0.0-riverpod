import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/cep_response.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';

class GetCepDetailsByLocalDetails {
  final CepRepository _cepRepository;

  GetCepDetailsByLocalDetails(this._cepRepository);

  Future<Either<CepException, List<CepResponse>?>> call(
      GetCepDetailsByLocalDetailsBody cep) {
    return _cepRepository.getCepDetailsByLocalDetails(cep);
  }
}
