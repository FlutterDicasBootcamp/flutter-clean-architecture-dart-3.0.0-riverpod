import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/shared_preferences_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localProvider = Provider<LocalService>(
  (ref) => SharedPreferencesService(),
);
