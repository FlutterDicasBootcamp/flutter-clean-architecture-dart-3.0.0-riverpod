import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/cep_response.dart';

void main() {
  test('should convert CepResponseModel to json', () {
    final cepJson = tCepObject.toJSON();

    expect(cepJson, equals(tCepLocalResponse));
  });

  test('should convert Map to CepResponseModel', () {
    final cepResponse = CepResponseModel.fromMap(tCepApiResponse);

    expect(cepResponse, equals(tCepObject));
  });

  test('should convert JSON to CepResponseModel', () {
    final cepResponse = CepResponseModel.fromJSON(tCepLocalResponse);

    expect(cepResponse, equals(tCepObject));
  });
}
