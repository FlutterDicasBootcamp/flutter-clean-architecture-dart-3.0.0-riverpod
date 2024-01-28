import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_cep_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/local/get_cep_details_by_local_details_local_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_locel_details_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/repositories/cep_repository_impl.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/no_internet_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_response.dart';

class MockGetCepDetailsByCepLocalDataSource extends Mock
    implements GetCepDetailsByCepLocalDataSource {}

class MockGetCepDetailsByCepRemoteDataSource extends Mock
    implements GetCepDetailsByCepRemoteDataSource {}

class MockGetCepDetailsByLocalDetailsLocalDataSource extends Mock
    implements GetCepDetailsByLocalDetailsLocalDataSource {}

class MockGetCepDetailsByLocalDetailsRemoteDataSource extends Mock
    implements GetCepDetailsByLocalDetailsRemoteDataSource {}

void main() {
  late CepRepository cepRepository;
  late MockGetCepDetailsByCepLocalDataSource mockGetCepDetailsByCepLocal;
  late MockGetCepDetailsByCepRemoteDataSource mockGetCepDetailsByCepRemote;
  late MockGetCepDetailsByLocalDetailsLocalDataSource
      mockGetCepDetailsByLocalDetailsLocal;
  late MockGetCepDetailsByLocalDetailsRemoteDataSource
      mockGetCepDetailsByLocalDetailsRemote;

  setUp(() {
    mockGetCepDetailsByCepLocal = MockGetCepDetailsByCepLocalDataSource();
    mockGetCepDetailsByCepRemote = MockGetCepDetailsByCepRemoteDataSource();
    mockGetCepDetailsByLocalDetailsLocal =
        MockGetCepDetailsByLocalDetailsLocalDataSource();
    mockGetCepDetailsByLocalDetailsRemote =
        MockGetCepDetailsByLocalDetailsRemoteDataSource();

    cepRepository = CepRepositoryImpl(
      mockGetCepDetailsByCepLocal,
      mockGetCepDetailsByCepRemote,
      mockGetCepDetailsByLocalDetailsRemote,
      mockGetCepDetailsByLocalDetailsLocal,
    );

    registerFallbackValue(tGetCepDetailsByCepBodyRight);
    registerFallbackValue(tCepObject);
  });

  group('get cep', () {
    test('success', () async {
      when(() => mockGetCepDetailsByCepRemote.call(any()))
          .thenAnswer((_) async => Right(tCepObject));
      when(() => mockGetCepDetailsByCepLocal.set(any()))
          .thenAnswer((_) async => Right(null));

      final cepEither =
          await cepRepository.getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepEither, isA<Right>());

      final cep = ((cepEither as Right).value as CepResponseModel);

      expect(cep, equals(tCepObject));
    });

    test('no connection returns cached cep', () async {
      when(() => mockGetCepDetailsByCepRemote.call(any()))
          .thenThrow(NoInternetException());
      when(() => mockGetCepDetailsByCepLocal.get())
          .thenAnswer((_) async => Right(tCepObject));

      final cepEither =
          await cepRepository.getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepEither, isA<Left>());
      final bairro =
          ((cepEither as Left).value as CepInternetConnectionException)
              .cep!
              .bairro;
      expect(bairro, equals(tCepObject.bairro));
    });

    test('remote and local fails', () async {
      const kErrorMessage = 'Error loading cep';

      when(() => mockGetCepDetailsByCepRemote.call(any()))
          .thenThrow(NoInternetException());
      when(() => mockGetCepDetailsByCepLocal.get()).thenAnswer(
          (_) async => Left(CepLocalException(message: kErrorMessage)));

      final cepEither =
          await cepRepository.getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepEither, isA<Left>());
      final errorMessage =
          ((cepEither as Left).value as CepLocalException).message;
      expect(errorMessage, equals(kErrorMessage));
    });
  });
}
