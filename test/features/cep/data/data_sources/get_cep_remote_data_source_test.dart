import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/const/get_cep_error_messages.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/get_cep_remote_data_source.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/errors/api_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/models/remote/api_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/cep_response.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  late ApiService apiService;
  late GetCepRemoteDataSource getCepRemoteDataSource;

  setUpAll(() {
    apiService = MockApiService();
    getCepRemoteDataSource = GetCepRemoteDataSourceImpl(apiService);
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

      final response = await getCepRemoteDataSource(tCepBodyRight);

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

    final response = await getCepRemoteDataSource.call(tCepBodyFail);

    expect(response, isA<Left>());
    expect((((response as Left).value) as CepRemoteException).message,
        equals(GetCepErrorMessages.invalidZipCode));
  });
}
