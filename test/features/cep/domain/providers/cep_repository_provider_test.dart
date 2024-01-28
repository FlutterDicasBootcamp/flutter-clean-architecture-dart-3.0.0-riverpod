import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/providers/get_cep_details_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final providerContainer = ProviderContainer();
  late dynamic getCepRemoteDataSource;
  late dynamic getCepLocalDatSource;

  setUp(() {
    getCepRemoteDataSource =
        providerContainer.read(getCepDetailsByCepRemoteDataSource);
    getCepLocalDatSource =
        providerContainer.read(getCepDetailsByCepLocalDataSource);
  });

  test('getCepRemoteDataSource is a GetCepRemoteDatSource', () {
    expect(getCepRemoteDataSource, isA<GetCepDetailsByCepRemoteDataSource>());
  });

  test('getCepLocalDatSource is a GetCepDetailsByCepLocalDataSource', () {
    expect(getCepLocalDatSource, isA<GetCepDetailsByCepLocalDataSource>());
  });
}
