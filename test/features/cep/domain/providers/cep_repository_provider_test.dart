import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/get_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/providers/cep_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final providerContainer = ProviderContainer();
  late dynamic getCepRemoteDataSource;
  late dynamic getCepLocalDatSource;

  setUpAll(() {
    getCepRemoteDataSource = providerContainer.read(cepRemoteDataSource);
    getCepLocalDatSource = providerContainer.read(cepLocalDataSource);
  });

  test('getCepRemoteDataSource is a GetCepRemoteDatSource', () {
    expect(getCepRemoteDataSource, isA<GetCepRemoteDataSource>());
  });

  test('getCepLocalDatSource is a CepLocalDataSource', () {
    expect(getCepLocalDatSource, isA<CepLocalDataSource>());
  });
}
