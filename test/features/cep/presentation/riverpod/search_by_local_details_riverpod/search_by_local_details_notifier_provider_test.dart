import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details_by_local_details.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/snack_bar_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../../fixtures/cep_fixtures.dart';

class MockGetCepDetailsByLocalDetails extends Mock
    implements GetCepDetailsByLocalDetails {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late GetCepDetailsByLocalDetails getCepDetailsByLocalDetailsMock;
  late SearchByLocalDetailsNotifier searchByLocalDetailsNotifier;
  late BuildContext buildContext;

  setUp(() {
    registerFallbackValue(tGetCepDetailsByLocalDetailsBodyRight);
    registerFallbackValue(SnackBarType.success);
  });

  setUp(() {
    getCepDetailsByLocalDetailsMock = MockGetCepDetailsByLocalDetails();

    searchByLocalDetailsNotifier =
        SearchByLocalDetailsNotifier(getCepDetailsByLocalDetailsMock);
    buildContext = MockBuildContext();
  });

  stateNotifierTest<SearchByLocalDetailsNotifier, SearchByLocalDetailsState>(
    'should not emit state when no methods are called',
    actions: (_) {},
    build: () => searchByLocalDetailsNotifier,
    expect: () => [],
  );

  group('Cep Notifier tests', () {
    stateNotifierTest<SearchByLocalDetailsNotifier, SearchByLocalDetailsState>(
        'should emit CepStateEnum.loading and CepStateEnum.loaded after loadAddressByLocalDetails is completed',
        build: () => searchByLocalDetailsNotifier,
        setUp: () {
          WidgetsFlutterBinding.ensureInitialized();
          when(() => getCepDetailsByLocalDetailsMock(any()))
              .thenAnswer((_) async => Right([tCepObject]));
        },
        actions: (_) async {
          await searchByLocalDetailsNotifier.loadAddressByLocalDetails(
              tGetCepDetailsByLocalDetailsBodyRight, buildContext);
        },
        expect: () => const [
              SearchByLocalDetailsState(
                  isLoading: true, state: CepStateEnum.loading),
              SearchByLocalDetailsState(
                localDetailsList: [tCepObject],
                isLoading: false,
                state: CepStateEnum.loaded,
              )
            ]);
    stateNotifierTest<SearchByLocalDetailsNotifier, SearchByLocalDetailsState>(
        'should emit CepStateEnum.loading and CepStateEnum.error after loadAddressByLocalDetails is completed',
        build: () => searchByLocalDetailsNotifier,
        setUp: () {
          WidgetsFlutterBinding.ensureInitialized();
          when(() => getCepDetailsByLocalDetailsMock(any()))
              .thenAnswer((_) async => Left(CepException()));
          when(() => buildContext.mounted).thenReturn(true);
        },
        actions: (_) async {
          await searchByLocalDetailsNotifier.loadAddressByLocalDetails(
              tGetCepDetailsByLocalDetailsBodyRight, buildContext);
        },
        expect: () => const [
              SearchByLocalDetailsState(
                  isLoading: true, state: CepStateEnum.loading),
              SearchByLocalDetailsState(
                errorMessage:
                    'Ocorreu um erro. Por favor tente novamente mais tarde.',
                isLoading: false,
                state: CepStateEnum.error,
              )
            ]);
  });
}
