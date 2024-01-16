import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/const/get_cep_error_messages.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/errors/api_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';

abstract interface class GetCepRemoteDataSource {
  Future<Either<CepRemoteException, CepResponseModel>> call(
      CepBodyModel cepBody);
}

class GetCepRemoteDataSourceImpl implements GetCepRemoteDataSource {
  final ApiService _api;

  GetCepRemoteDataSourceImpl(this._api);

  @override
  Future<Either<CepRemoteException, CepResponseModel>> call(
      CepBodyModel cepBody) async {
    final cepEither = await _api.get('/ws/${cepBody.cep}/json/');

    switch (cepEither) {
      case Left(value: final l):
        return switch (l.errorStatus) {
          ErrorStatus.noConnection => throw NoInternetException(),
          ErrorStatus.badRequest => Left(
              CepRemoteException(message: GetCepErrorMessages.invalidZipCode)),
          _ => Left(CepRemoteException(message: l.message)),
        };
      case Right(value: final r):
        return Right(CepResponseModel.fromMap(r.data));
    }
  }
}
