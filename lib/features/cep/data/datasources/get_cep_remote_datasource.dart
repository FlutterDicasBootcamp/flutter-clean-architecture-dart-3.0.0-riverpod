import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/errors/get_cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/errors/api_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';

abstract interface class CepRemoteDatasource {
  Future<Either<GetCepRemoteException, CepResponseModel>> call(
      CepBodyModel cepBody);
}

class CepRemoteDatasourceImpl implements CepRemoteDatasource {
  final ApiService _api;

  CepRemoteDatasourceImpl(this._api);

  @override
  Future<Either<GetCepRemoteException, CepResponseModel>> call(
      CepBodyModel cepBody) async {
    final cepEither = await _api.get('/ws/${cepBody.cep}/json/');

    switch (cepEither) {
      case Left():
        return switch (cepEither.value.errorStatus) {
          ErrorStatus.noConnection => throw NoInternetException(),
          _ => Left(GetCepRemoteException(message: cepEither.value.message)),
        };
      case Right():
        return Right(CepResponseModel.fromMap(cepEither.value.data));
    }
  }
}
