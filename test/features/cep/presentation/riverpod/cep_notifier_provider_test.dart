import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/snack_bar_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/cep_response.dart';

class MockCepRepository extends Mock implements CepRepository {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late CepRepository cepRepository;
  late CepNotifier cepNotifier;
  late BuildContext buildContext;

  setUpAll(() {
    registerFallbackValue(CepBodyModel('00000000'));
    registerFallbackValue(SnackBarType.success);
  });

  setUp(() {
    cepRepository = MockCepRepository();
    cepNotifier = CepNotifier(cepRepository);
    buildContext = MockBuildContext();
  });

  stateNotifierTest<CepNotifier, CepState>(
    'should not emit state when no methods are called',
    actions: (_) {},
    build: () => cepNotifier,
    expect: () => [],
  );

  group('Cep Notifier tests', () {
    stateNotifierTest<CepNotifier, CepState>(
        'should emit CepStateEnum.loading and CepStateEnum.loaded after loadAddress is completed',
        build: () => cepNotifier,
        setUp: () {
          WidgetsFlutterBinding.ensureInitialized();
          when(() => cepRepository.call(any()))
              .thenAnswer((_) async => Right(tCepObject));
        },
        actions: (_) async {
          await cepNotifier.loadAddress('00000000', buildContext);
        },
        expect: () => const [
              CepState(isLoading: true, state: CepStateEnum.loading),
              CepState(
                cep: tCepObject,
                isLoading: false,
                state: CepStateEnum.loaded,
              )
            ]);
    stateNotifierTest<CepNotifier, CepState>(
        'should emit CepStateEnum.loading and CepStateEnum.error after loadAddress is completed',
        build: () => cepNotifier,
        setUp: () {
          WidgetsFlutterBinding.ensureInitialized();
          when(() => cepRepository.call(any()))
              .thenAnswer((_) async => Left(CepException()));
          when(() => buildContext.mounted).thenReturn(true);
        },
        actions: (_) async {
          await cepNotifier.loadAddress('00000000', buildContext);
        },
        expect: () => const [
              CepState(isLoading: true, state: CepStateEnum.loading),
              CepState(
                errorMessage:
                    'Ocorreu um erro. Por favor tente novamente mais tarde.',
                isLoading: false,
                state: CepStateEnum.error,
              )
            ]);
  });
}
