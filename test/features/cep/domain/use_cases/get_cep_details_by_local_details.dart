import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCepRepository extends Mock implements CepRepository {}

void main() {
  late CepRepository _mockCepRepository;

  setUp(() {
    _mockCepRepository = MockCepRepository();
  });

  test('should get cep details by local details', () {});
}
