import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/const/get_cep_error_messages.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/const/validation_messages_const.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/tabs/search_by_cep_tab_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/main/cep_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cep Screen', () {
    testWidgets('should find AppBar title', (tester) async {
      await tester.pumpWidget(const CepApp());

      final title = find.text('Cep App - Clean Architecture');

      expect(title, findsOneWidget);
    });

    testWidgets('should find insert zip code label', (tester) async {
      await tester.pumpWidget(const CepApp());

      final insertAZipCode = find.text('Insira um CEP:');

      expect(insertAZipCode, findsOneWidget);
    });

    testWidgets('should show required zip code validation error',
        (tester) async {
      await tester.pumpWidget(const CepApp());

      final button = find.byKey(searchZipCodeKey);

      await tester.tap(button);

      await tester.pumpAndSettle();

      final errorValidationText =
          find.text(ValidationCepMessagesConst.notEmpty('CEP'));

      expect(errorValidationText, findsOneWidget);
    });

    testWidgets('should get invalid zip code', (tester) async {
      await tester.pumpWidget(const CepApp());

      final input = find.byKey(zipCodeInput);

      await tester.enterText(input, '000');

      final button = find.byKey(searchZipCodeKey);

      await tester.tap(button);

      await tester.pumpAndSettle();

      final errorValidationText =
          find.text(ValidationCepMessagesConst.notEmpty('CEP'));
      final errorInvalidZipCode = find.text(GetCepErrorMessages.invalidZipCode);

      expect(errorValidationText, findsNothing);
      expect(errorInvalidZipCode, findsOneWidget);
    });
  });
}
