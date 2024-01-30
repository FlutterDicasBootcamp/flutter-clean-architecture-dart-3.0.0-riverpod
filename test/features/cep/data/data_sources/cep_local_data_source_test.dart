import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/errors/local_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/local_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_fixtures.dart';

class MockLocalService extends Mock implements LocalService {}

void main() {
  late LocalService mockLocalService;
  late GetCepDetailsByCepLocalDataSource cepLocalDataSource;

  setUp(() {
    mockLocalService = MockLocalService();
    cepLocalDataSource =
        GetCepDetailsByCepLocalDataSourceImpl(mockLocalService);
  });

  group('set cep local datasource', () {
    test('success', () async {
      when(() => mockLocalService.set<String>(any(), any()))
          .thenAnswer((_) async => Right(null));

      final localCep = await cepLocalDataSource.set(tCepObject);

      expect(localCep, isA<Right>());
    });

    test('fail', () async {
      const errorMessage = 'Error set local';
      when(() => mockLocalService.set<String>(any(), any())).thenAnswer(
          (_) async => Left(const LocalException(message: errorMessage)));

      final localCep = await cepLocalDataSource.set(tCepObject);

      expect(localCep, isA<Left>());
      expect(((localCep as Left).value as CepLocalException).message,
          errorMessage);
    });
  });

  group('get cep local datasource', () {
    test('success', () async {
      when(() => mockLocalService.get<String>(any()))
          .thenAnswer((_) async => Right(tCepLocalResponse));

      final localCep = await cepLocalDataSource.get();

      expect(localCep, isA<Right>());
    });
    test('fail', () async {
      const errorMessage = 'Error get local';

      when(() => mockLocalService.get<String>(any())).thenAnswer(
          (_) async => Left(const LocalException(message: errorMessage)));

      final localCep = await cepLocalDataSource.get();

      expect(localCep, isA<Left>());
      expect(((localCep as Left).value as CepLocalException).message,
          errorMessage);
    });
  });
}
