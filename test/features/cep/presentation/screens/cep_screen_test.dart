import 'package:flutter_dicas_cep_clean_architecture/shared/main/cep_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cep Screen', () {
    testWidgets('should find AppBar title', (tester) async {
      await tester.pumpWidget(const CepApp());

      final title = find.text('Cep App - Clean Architecture');

      expect(title, findsOneWidget);
    });
  });
}
