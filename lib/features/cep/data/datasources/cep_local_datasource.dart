import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/errors/get_cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';

abstract interface class CepLocalDatasource {
  Future<Either<GetCepLocalException, CepResponseModel?>> get();
  Future<Either<GetCepLocalException, void>> set(CepResponseModel cep);
}

const CEP_LOCAL_KEY = 'CEP_LOCAL_KEY';

class CepLocalDatasourceImpl implements CepLocalDatasource {
  final LocalService _sharedPreferences;

  CepLocalDatasourceImpl(this._sharedPreferences);

  @override
  Future<Either<GetCepLocalException, CepResponseModel?>> get() async {
    final localCep = await _sharedPreferences.get<String>(CEP_LOCAL_KEY);

    return switch (localCep) {
      Left() => Left(GetCepLocalException()),
      Right(value: final r) =>
        Right(r != null ? CepResponseModel.fromJSON(r) : null),
    };
  }

  @override
  Future<Either<GetCepLocalException, void>> set(CepResponseModel cep) async {
    final localCep =
        await _sharedPreferences.set<String>(CEP_LOCAL_KEY, cep.toJSON());

    return switch (localCep) {
      Left() => Left(GetCepLocalException()),
      Right() => Right(null),
    };
  }
}
