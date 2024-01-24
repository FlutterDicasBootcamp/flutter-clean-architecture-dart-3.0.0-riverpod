import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/get_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/repositories/cep_repository_impl.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/local_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/providers/api_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/providers/local_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cepRemoteDataSource = Provider<GetCepRemoteDataSource>(
    (ref) => GetCepRemoteDataSourceImpl(ref.read<ApiService>(apiProvider)));

final cepLocalDataSource = Provider<CepLocalDataSource>(
    (ref) => CepLocalDataSourceImpl(ref.read<LocalService>(localProvider)));

final cepRepository = Provider<CepRepository>(
  (ref) => CepRepositoryImpl(
    ref.read<CepLocalDataSource>(cepLocalDataSource),
    ref.read<GetCepRemoteDataSource>(cepRemoteDataSource),
  ),
);

final getCepDetails = Provider<GetCepDetails>((ref) => GetCepDetails(
      ref.read<CepRepository>(cepRepository),
    ));
