import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details_by_cep.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/snack_bar_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../../fixtures/cep_fixtures.dart';

class MockGetCepDetailsByCep extends Mock implements GetCepDetailsByCep {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late GetCepDetailsByCep getCepDetailsByCepMock;
  late SearchByCepNotifier cepNotifier;
  late BuildContext buildContext;

  setUp(() {
    registerFallbackValue(const GetCepDetailsByCepBody('00000000'));
    registerFallbackValue(SnackBarType.success);
  });

  setUp(() {
    getCepDetailsByCepMock = MockGetCepDetailsByCep();

    cepNotifier = SearchByCepNotifier(getCepDetailsByCepMock);
    buildContext = MockBuildContext();
  });

  stateNotifierTest<SearchByCepNotifier, SearchByCepState>(
    'should not emit state when no methods are called',
    actions: (_) {},
    build: () => cepNotifier,
    expect: () => [],
  );

  group('Cep Notifier tests', () {
    stateNotifierTest<SearchByCepNotifier, SearchByCepState>(
        'should emit CepStateEnum.loading and CepStateEnum.loaded after loadAddressByCep is completed',
        build: () => cepNotifier,
        setUp: () {
          WidgetsFlutterBinding.ensureInitialized();
          when(() => getCepDetailsByCepMock(any()))
              .thenAnswer((_) async => Right(tCepObject));
        },
        actions: (_) async {
          await cepNotifier.loadAddressByCep('00000000', buildContext);
        },
        expect: () => const [
              SearchByCepState(isLoading: true, state: CepStateEnum.loading),
              SearchByCepState(
                cep: tCepObject,
                isLoading: false,
                state: CepStateEnum.loaded,
              )
            ]);
    stateNotifierTest<SearchByCepNotifier, SearchByCepState>(
        'should emit CepStateEnum.loading and CepStateEnum.error after loadAddressByCep is completed',
        build: () => cepNotifier,
        setUp: () {
          WidgetsFlutterBinding.ensureInitialized();
          when(() => getCepDetailsByCepMock(any()))
              .thenAnswer((_) async => Left(CepException()));
          when(() => buildContext.mounted).thenReturn(true);
        },
        actions: (_) async {
          await cepNotifier.loadAddressByCep('00000000', buildContext);
        },
        expect: () => const [
              SearchByCepState(isLoading: true, state: CepStateEnum.loading),
              SearchByCepState(
                errorMessage:
                    'Ocorreu um erro. Por favor tente novamente mais tarde.',
                isLoading: false,
                state: CepStateEnum.error,
              )
            ]);
  });
}
