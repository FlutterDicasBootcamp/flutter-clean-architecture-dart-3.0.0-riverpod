import 'dart:convert';

import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/local_service.dart';

abstract interface class GetCepDetailsByLocalDetailsLocalDataSource {
  Future<Either<CepLocalException, List<CepResponseModel>?>> get();
  Future<Either<CepLocalException, void>> set(List<CepResponseModel> cep);
}

const GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY = 'GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY';

class GetCepDetailsByLocalDetailsLocalDataSourceImpl
    implements GetCepDetailsByLocalDetailsLocalDataSource {
  final LocalService _sharedPreferences;

  GetCepDetailsByLocalDetailsLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<Either<CepLocalException, List<CepResponseModel>?>> get() async {
    final localCep = await _sharedPreferences
        .get<String>(GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY);

    return switch (localCep) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right(value: final r) => Right(r != null
          ? (CepResponseModel.fromJSON(r) as List)
              .map((localDetails) => CepResponseModel.fromMap(localDetails))
              .toList()
          : null),
    };
  }

  @override
  Future<Either<CepLocalException, void>> set(
      List<CepResponseModel> cep) async {
    final localCep = await _sharedPreferences.set<String>(
      GET_CEP_BY_LOCAL_DETAILS_LOCAL_KEY,
      jsonEncode(cep.map((localDetails) => localDetails.toMap()).toList()),
    );

    return switch (localCep) {
      Left(value: final l) => Left(CepLocalException(message: l.message)),
      Right() => Right(null),
    };
  }
}
