import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/errors/get_cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/cep_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/get_cep_remote_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';

class CepRepositoryImpl implements CepRepository {
  final CepLocalDatasource _cepLocal;
  final CepRemoteDatasource _getCepRemote;

  CepRepositoryImpl(this._cepLocal, this._getCepRemote);

  @override
  Future<Either<GetCepException, CepResponseModel?>> call(
      CepBodyModel cep) async {
    try {
      final cepEither = await _getCepRemote(cep);

      switch (cepEither) {
        case Left():
          return Left(cepEither.value);
        case Right():
          await _cepLocal.set(cepEither.value);
          return Right(cepEither.value);
      }
    } on NoInternetException {
      final localCep = await _cepLocal.get();

      return switch (localCep) {
        Left() => Left(GetCepLocalException(message: localCep.value.message)),
        Right() => Left(GetCepInternetConnectionException(cep: localCep.value)),
      };
    }
  }
}
