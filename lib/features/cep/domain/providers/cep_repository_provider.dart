import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/cep_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/get_cep_remote_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/repositories/cep_repository_impl.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/providers/api_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/providers/local_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _cepRemoteDatasource = Provider<CepRemoteDatasource>(
    (ref) => CepRemoteDatasourceImpl(ref.watch<ApiService>(apiProvider)));

final _cepLocalDatasource = Provider<CepLocalDatasource>(
    (ref) => CepLocalDatasourceImpl(ref.watch<LocalService>(localProvider)));

final cepRepository = Provider<CepRepository>(
  (ref) => CepRepositoryImpl(
    ref.watch<CepLocalDatasource>(_cepLocalDatasource),
    ref.watch<CepRemoteDatasource>(_cepRemoteDatasource),
  ),
);
