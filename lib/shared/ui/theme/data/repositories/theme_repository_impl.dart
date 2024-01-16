import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/datasources/get_theme_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/datasources/set_theme_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/errors/theme_local_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final SetThemeLocalDataSource _setThemeLocalDataSource;
  final GetThemeLocalDataSource _getThemeLocalDataSource;

  ThemeRepositoryImpl(
      this._setThemeLocalDataSource, this._getThemeLocalDataSource);

  @override
  Future<bool> getIsLightTheme() {
    return _getThemeLocalDataSource.getIsLightTheme();
  }

  @override
  Future<Either<ThemeLocalException, void>> setIsLightTheme(bool isLightTheme) {
    return _setThemeLocalDataSource.setIsLightTheme(isLightTheme);
  }
}
