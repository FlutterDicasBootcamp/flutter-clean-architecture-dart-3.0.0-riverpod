import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/const/get_cep_error_messages.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/errors/api_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';

abstract interface class GetCepDetailsByLocalDetailsRemoteDataSource {
  Future<Either<CepRemoteException, List<CepResponseModel>>> call(
      GetCepDetailsByLocalDetailsBody localDetailsBody);
}

class GetCepDetailsByLocalDetailsRemoteDataSourceImpl
    implements GetCepDetailsByLocalDetailsRemoteDataSource {
  final ApiService _api;

  GetCepDetailsByLocalDetailsRemoteDataSourceImpl(this._api);

  @override
  Future<Either<CepRemoteException, List<CepResponseModel>>> call(
      GetCepDetailsByLocalDetailsBody localDetailsBody) async {
    final cepEither = await _api.get(
        '${localDetailsBody.estado}/${localDetailsBody.cidade}/${localDetailsBody.rua}/json/');

    switch (cepEither) {
      case Left(value: final l):
        return switch (l.errorStatus) {
          ErrorStatus.noConnection => throw NoInternetException(),
          ErrorStatus.badRequest => Left(CepRemoteException(
              message: GetCepErrorMessages.invalidLocalDetails)),
          _ => Left(CepRemoteException(message: l.message)),
        };
      case Right(value: final r):
        return Right((r.data as List)
            .map((localDetails) => CepResponseModel.fromMap(localDetails))
            .toList());
    }
  }
}
