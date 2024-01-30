import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details_by_cep.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/const/const_strings.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_fixtures.dart';

class MockCepRepository extends Mock implements CepRepository {}

void main() {
  late CepRepository mockCepRepository;
  late GetCepDetailsByCep getCepDetailsByCep;

  setUp(() {
    mockCepRepository = MockCepRepository();
    getCepDetailsByCep = GetCepDetailsByCep(mockCepRepository);
    registerFallbackValue(tGetCepDetailsByCepBodyRight);
  });

  group('should get cep details by CEP', () {
    test('success', () async {
      when(() => mockCepRepository.getCepDetailsByCep(any()))
          .thenAnswer((_) async => Right(tCepObject));

      final cepResponse =
          await getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepResponse, isA<Right>());
    });

    test('fail', () async {
      when(() => mockCepRepository.getCepDetailsByCep(any())).thenAnswer(
        (_) async => Left(
          CepException(
            message: ConstStrings.kDefaultErrorMessage,
          ),
        ),
      );

      final cepResponse =
          await getCepDetailsByCep(tGetCepDetailsByCepBodyRight);

      expect(cepResponse, isA<Left>());

      expect(((cepResponse as Left).value as CepException).message,
          ConstStrings.kDefaultErrorMessage);
    });
  });
}
