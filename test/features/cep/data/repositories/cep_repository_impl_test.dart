import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/get_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/repositories/cep_repository_impl.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_response.dart';

class MockCepLocal extends Mock implements CepLocalDataSource {}

class MockCepRemote extends Mock implements GetCepRemoteDataSource {}

void main() {
  late CepRepository cepRepository;
  late MockCepLocal mockCepLocal;
  late MockCepRemote mockCepRemote;

  setUpAll(() {
    mockCepLocal = MockCepLocal();
    mockCepRemote = MockCepRemote();

    cepRepository = CepRepositoryImpl(mockCepLocal, mockCepRemote);

    registerFallbackValue(tCepBodyRight);
    registerFallbackValue(tCepObject);
  });

  group('get cep', () {
    test('success', () async {
      when(() => mockCepRemote.call(any()))
          .thenAnswer((_) async => Right(tCepObject));
      when(() => mockCepLocal.set(any())).thenAnswer((_) async => Right(null));

      final cepEither = await cepRepository(tCepBodyRight);

      expect(cepEither, isA<Right>());

      final cep = ((cepEither as Right).value as CepResponseModel);

      expect(cep, equals(tCepObject));
    });

    test('no connection returns cached cep', () async {
      when(() => mockCepRemote.call(any())).thenThrow(NoInternetException());
      when(() => mockCepLocal.get()).thenAnswer((_) async => Right(tCepObject));

      final cepEither = await cepRepository(tCepBodyRight);

      expect(cepEither, isA<Left>());
      final bairro =
          ((cepEither as Left).value as CepInternetConnectionException)
              .cep!
              .bairro;
      expect(bairro, equals(tCepObject.bairro));
    });

    test('remote and local fails', () async {
      const kErrorMessage = 'Error loading cep';

      when(() => mockCepRemote.call(any())).thenThrow(NoInternetException());
      when(() => mockCepLocal.get()).thenAnswer(
          (_) async => Left(CepLocalException(message: kErrorMessage)));

      final cepEither = await cepRepository(tCepBodyRight);

      expect(cepEither, isA<Left>());
      final errorMessage =
          ((cepEither as Left).value as CepLocalException).message;
      expect(errorMessage, equals(kErrorMessage));
    });
  });
}
