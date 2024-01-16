import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/local_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/cep_response.dart';

void main() {
  late LocalService sharedPreferencesService;

  setUpAll(() {
    // TestWidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setMockInitialValues({});
    sharedPreferencesService = SharedPreferencesService();
  });

  group('Set and get Bool Local', () {
    test('returns null', () async {
      final response = await sharedPreferencesService.get<bool>('bool');

      expect((response as Right).value, equals(null));
    });

    test('return bool', () async {
      await sharedPreferencesService.set<bool>('bool', false);

      final response = await sharedPreferencesService.get<bool>('bool');

      expect((response as Right).value, false);
    });
  });

  group("Set and get String Local", () {
    test('fail', () async {
      final response = await sharedPreferencesService.get<String>('cep');

      expect((response as Right).value, equals(null));
    });

    test('success', () async {
      await sharedPreferencesService.set<String>('cep', tCepLocalResponse);

      final response = await sharedPreferencesService.get<String>('cep');

      expect((response as Right).value, tCepLocalResponse);
    });
  });
}
