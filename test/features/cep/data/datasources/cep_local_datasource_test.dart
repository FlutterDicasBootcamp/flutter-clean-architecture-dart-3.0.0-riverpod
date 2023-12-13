import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/datasources/cep_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_response.dart';

class MockLocalService extends Mock implements LocalService {}

void main() {
  late LocalService localService;
  late CepLocalDatasource cepLocalDatasource;

  setUpAll(() {
    localService = MockLocalService();
    cepLocalDatasource = CepLocalDatasourceImpl(localService);
  });

  group('set cep local datasource', () {
    test('success', () async {
      when(() => localService.set(any(), any()))
          .thenAnswer((invocation) => Future.value(Right(null)));

      final localCep = await cepLocalDatasource.set(tCepObject);

      expect(localCep, isA<Right>());
    });
  });

  group('get cep local datasource', () {
    test('success', () async {
      when(() => localService.get(any()))
          .thenAnswer((invocation) => Future.value(Right(tCepApiResponse)));

      final localCep = await cepLocalDatasource.get();

      expect(localCep, isA<Right>());
    });
  });
}
