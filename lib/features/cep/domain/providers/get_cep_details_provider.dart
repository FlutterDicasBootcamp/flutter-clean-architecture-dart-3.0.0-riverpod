import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_local_details_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_locel_details_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/repositories/cep_repository_impl.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details_by_cep.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details_by_local_details.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/local_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/providers/api_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/providers/local_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getCepDetailsByCepRemoteDataSource =
    Provider<GetCepDetailsByCepRemoteDataSource>((ref) =>
        GetCepDetailsByCepRemoteDataSourceImpl(
            ref.read<ApiService>(apiProvider)));

final getCepDetailsByCepLocalDataSource =
    Provider<GetCepDetailsByCepLocalDataSource>((ref) =>
        GetCepDetailsByCepLocalDataSourceImpl(
            ref.read<LocalService>(localProvider)));

final getCepDetailsByLocalDetailsRemoteDataSource =
    Provider<GetCepDetailsByLocalDetailsRemoteDataSource>((ref) =>
        GetCepDetailsByLocalDetailsRemoteDataSourceImpl(
            ref.read<ApiService>(apiProvider)));

final getCepDetailsByLocalDetailsLocalDataSource =
    Provider<GetCepDetailsByLocalDetailsLocalDataSource>((ref) =>
        GetCepDetailsByLocalDetailsLocalDataSourceImpl(
            ref.read<LocalService>(localProvider)));

final cepRepository = Provider<CepRepository>(
  (ref) => CepRepositoryImpl(
    ref.read<GetCepDetailsByCepLocalDataSource>(
        getCepDetailsByCepLocalDataSource),
    ref.read<GetCepDetailsByCepRemoteDataSource>(
        getCepDetailsByCepRemoteDataSource),
    ref.read<GetCepDetailsByLocalDetailsRemoteDataSource>(
        getCepDetailsByLocalDetailsRemoteDataSource),
    ref.read<GetCepDetailsByLocalDetailsLocalDataSource>(
        getCepDetailsByLocalDetailsLocalDataSource),
  ),
);

final getCepDetailsByCep =
    Provider<GetCepDetailsByCep>((ref) => GetCepDetailsByCep(
          ref.read<CepRepository>(cepRepository),
        ));

final getCepDetailsByLocalDetails =
    Provider<GetCepDetailsByLocalDetails>((ref) => GetCepDetailsByLocalDetails(
          ref.read<CepRepository>(cepRepository),
        ));
