import 'package:dio/dio.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/dio_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio mockApiService;
  late DioService dioService;

  setUpAll(() {
    mockApiService = MockDio();
    dioService = DioService(mockApiService);
  });

  group('GET Request', () {
    test('success', () async {
      when(() => mockApiService.get(any())).thenAnswer(
        (_) => Future.value(
          Response(data: {}, statusCode: 200, requestOptions: RequestOptions()),
        ),
      );

      final response = await dioService.get('');

      expect(response, isA<Right>());
    });

    test('fail', () async {
      when(() => mockApiService.get(any()))
          .thenThrow(DioException(requestOptions: RequestOptions()));

      final response = await dioService.get('');

      expect(response, isA<Left>());
    });
  });
}
