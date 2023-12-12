import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/cep_response.dart';

void main() {
  late LocalService sharedPreferencesService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setMockInitialValues({'cep': tCepCacheResponse});
    sharedPreferencesService = SharedPreferencesService();
  });

  group('Get Bool Local', () {
    test('success', () async {
      final response = await sharedPreferencesService.get<bool>('cep');

      expect(response, Right(false));
    });

    // test('fail', () async {

    //   final response = await sharedPreferencesService.get<bool>('cep');

    //   expect(response, isA<Left>());
    // });
  });
}
