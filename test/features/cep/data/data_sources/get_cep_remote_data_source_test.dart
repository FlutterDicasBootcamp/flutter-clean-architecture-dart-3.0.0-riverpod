import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/const/get_cep_error_messages.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/remote/get_cep_details_by_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/errors/api_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/models/remote/api_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_fixtures.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late ApiService apiService;
  late GetCepDetailsByCepRemoteDataSource getCepRemoteDataSource;

  setUp(() {
    apiService = MockApiService();
    getCepRemoteDataSource = GetCepDetailsByCepRemoteDataSourceImpl(apiService);
  });

  group('get cep remote data source', () {
    test('success', () async {
      when(() => apiService.get(any())).thenAnswer(
        (_) async => Right(
          const ApiResponseModel(
            data: tCepApiResponse,
            statusCode: 200,
          ),
        ),
      );

      final response =
          await getCepRemoteDataSource(tGetCepDetailsByCepBodyRight);

      expect(response, isA<Right>());
      expect((((response as Right).value) as CepResponseModel).cep,
          equals(CepResponseModel.fromMap(tCepApiResponse).cep));
    });
  });

  test('fail', () async {
    when(() => apiService.get(any())).thenAnswer(
      (_) async => Left(
        ApiException(
            identifier: 'Get Cep fail',
            statusCode: 400,
            errorStatus: ErrorStatus.badRequest,
            message: '400 bad request'),
      ),
    );

    final response =
        await getCepRemoteDataSource.call(tGetCepDetailsByCepBodyFail);

    expect(response, isA<Left>());
    expect((((response as Left).value) as CepRemoteException).message,
        equals(GetCepErrorMessages.invalidZipCode));
  });
}
