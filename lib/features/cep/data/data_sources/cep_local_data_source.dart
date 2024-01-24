import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/local_service.dart';

abstract interface class CepLocalDataSource {
  Future<Either<CepLocalException, CepResponseModel?>> get();
  Future<Either<CepLocalException, void>> set(CepResponseModel cep);
}

const CEP_LOCAL_KEY = 'CEP_LOCAL_KEY';

class CepLocalDataSourceImpl implements CepLocalDataSource {
  final LocalService _sharedPreferences;

  CepLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<Either<CepLocalException, CepResponseModel?>> get() async {
    final localCep = await _sharedPreferences.get<String>(CEP_LOCAL_KEY);

    return switch (localCep) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right(value: final r) =>
        Right(r != null ? CepResponseModel.fromJSON(r) : null),
    };
  }

  @override
  Future<Either<CepLocalException, void>> set(CepResponseModel cep) async {
    final localCep =
        await _sharedPreferences.set<String>(CEP_LOCAL_KEY, cep.toJSON());

    return switch (localCep) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right() => Right(null),
    };
  }
}
