import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/const/validation_messages_const.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/app_bars/cep_screen_app_bar_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/tabs/search_by_local_details_tab_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/main/cep_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SearchByLocalDetailsTabWidget', () {
    testWidgets('should find insert local label', (tester) async {
      await tester.pumpWidget(const CepApp());

      final localDetailsTabButton = find.byKey(localDetailsKey);

      await tester.tap(localDetailsTabButton, warnIfMissed: false);

      await tester.pumpAndSettle();

      final insertAZipCode = find.text('Insira um Local:');

      expect(insertAZipCode, findsOneWidget);
    });

    testWidgets('should show required local details form validations errors',
        (tester) async {
      await tester.pumpWidget(const CepApp());

      final localDetailsTabButton = find.byKey(localDetailsKey);

      await tester.ensureVisible(localDetailsTabButton);

      await tester.pumpAndSettle();

      await tester.tap(localDetailsTabButton, warnIfMissed: false);

      await tester.pumpAndSettle();

      final button = find.byKey(searchZipCodeByLocalDetailsButtonKey);

      await tester.tap(button);

      await tester.pumpAndSettle();

      final errorStateValidationText =
          find.text(ValidationCepMessagesConst.notEmpty('Estado'));

      expect(errorStateValidationText, findsOneWidget);

      final errorCityValidationText =
          find.text(ValidationCepMessagesConst.notEmpty('Cidade'));

      expect(errorCityValidationText, findsOneWidget);

      final errorStreetValidationText =
          find.text(ValidationCepMessagesConst.notEmpty('Rua'));

      expect(errorStreetValidationText, findsOneWidget);
    });

    // testWidgets('should get invalid zip code', (tester) async {
    //   await tester.pumpWidget(const CepApp());

    //   final input = find.byKey(zipCodeInput);

    //   await tester.enterText(input, '000');

    //   final button = find.byKey(searchZipCodeKey);

    //   await tester.tap(button);

    //   await tester.pumpAndSettle();

    //   final errorValidationText =
    //       find.text(ValidationCepMessagesConst.notEmpty('CEP'));
    //   final errorInvalidZipCode = find.text(GetCepErrorMessages.invalidZipCode);

    //   expect(errorValidationText, findsNothing);
    //   expect(errorInvalidZipCode, findsOneWidget);
    // });
  });
}
