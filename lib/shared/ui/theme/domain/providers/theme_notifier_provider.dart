import 'package:flutter_dicas_cep_clean_architecture/shared/data/local/local_service/shared_preferences_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/datasources/get_theme_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/datasources/set_theme_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/repositories/theme_repository_impl.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeState>(
  (ref) => ThemeNotifier(ThemeRepositoryImpl(
    SetThemeLocalDataSourceImpl(
      SharedPreferencesService(),
    ),
    GetThemeLocalDataSourceImpl(
      SharedPreferencesService(),
    ),
  )),
);
