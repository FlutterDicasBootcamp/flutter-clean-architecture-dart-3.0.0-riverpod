import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/get_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';

class CepRepositoryImpl implements CepRepository {
  final CepLocalDataSource _cepLocal;
  final GetCepRemoteDataSource _getCepRemote;

  CepRepositoryImpl(this._cepLocal, this._getCepRemote);

  @override
  Future<Either<CepException, CepResponseModel?>> call(CepBodyModel cep) async {
    try {
      final cepEither = await _getCepRemote(cep);

      switch (cepEither) {
        case Left(value: final l):
          return Left(l);
        case Right(value: final r):
          await _cepLocal.set(r);
          return Right(r);
      }
    } on NoInternetException {
      final localCep = await _cepLocal.get();

      return switch (localCep) {
        Left(value: final l) => Left(CepLocalException(message: l.message)),
        Right(value: final r) => Left(CepInternetConnectionException(cep: r)),
      };
    }
  }
}
