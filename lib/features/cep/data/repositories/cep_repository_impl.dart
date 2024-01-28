import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_local_details_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_locel_details_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/cep_response.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';

class CepRepositoryImpl implements CepRepository {
  final GetCepDetailsByCepLocalDataSource _getByCepLocal;
  final GetCepDetailsByCepRemoteDataSource _getByCepRemote;

  final GetCepDetailsByLocalDetailsRemoteDataSource _getByLocalDetailsRemote;
  final GetCepDetailsByLocalDetailsLocalDataSource _getByLocalDetailsLocal;

  CepRepositoryImpl(
    this._getByCepLocal,
    this._getByCepRemote,
    this._getByLocalDetailsRemote,
    this._getByLocalDetailsLocal,
  );

  @override
  Future<Either<CepException, CepResponseModel?>> getCepDetailsByCep(
      GetCepDetailsByCepBody cep) async {
    try {
      final cepEither = await _getByCepRemote(cep);

      switch (cepEither) {
        case Left(value: final l):
          return Left(l);
        case Right(value: final r):
          await _getByCepLocal.set(r);
          return Right(r);
      }
    } on NoInternetException {
      final localCep = await _getByCepLocal.get();

      return switch (localCep) {
        Left(value: final l) => Left(CepLocalException(message: l.message)),
        Right(value: final r) => Left(CepInternetConnectionException(cep: r)),
      };
    }
  }

  @override
  Future<Either<CepException, List<CepResponse>?>> getCepDetailsByLocalDetails(
      GetCepDetailsByLocalDetailsBody cep) async {
    try {
      final cepEither = await _getByLocalDetailsRemote(cep);

      switch (cepEither) {
        case Left(value: final l):
          return Left(l);
        case Right(value: final r):
          await _getByLocalDetailsLocal.set(r);
          return Right(r);
      }
    } on NoInternetException {
      final localCep = await _getByLocalDetailsLocal.get();

      return switch (localCep) {
        Left(value: final l) => Left(CepLocalException(message: l.message)),
        Right(value: final r) =>
          Left(LocalDetailsInternetConnectionException(cep: r)),
      };
    }
  }
}
