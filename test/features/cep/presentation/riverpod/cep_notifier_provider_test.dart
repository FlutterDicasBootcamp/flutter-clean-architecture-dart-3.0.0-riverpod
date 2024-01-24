import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/snack_bar_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/cep_response.dart';

class MockGetCepDetails extends Mock implements GetCepDetails {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late GetCepDetails getCepDetailsMock;
  late CepNotifier cepNotifier;
  late BuildContext buildContext;

  setUpAll(() {
    registerFallbackValue(const CepBody('00000000'));
    registerFallbackValue(SnackBarType.success);
  });

  setUp(() {
    getCepDetailsMock = MockGetCepDetails();
    cepNotifier = CepNotifier(getCepDetailsMock);
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
          when(() => getCepDetailsMock(any()))
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
          when(() => getCepDetailsMock(any()))
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
