import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/datasources/get_theme_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/datasources/set_theme_local_datasource.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/errors/theme_local_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final SetThemeLocalDatasource _setThemeLocalDatasource;
  final GetThemeLocalDatasource _getThemeLocalDatasource;

  ThemeRepositoryImpl(
      this._setThemeLocalDatasource, this._getThemeLocalDatasource);

  @override
  Future<bool> getIsLightTheme() {
    return _getThemeLocalDatasource.getIsLightTheme();
  }

  @override
  Future<Either<ThemeLocalException, void>> setIsLightTheme(bool isLightTheme) {
    return _setThemeLocalDatasource.setIsLightTheme(isLightTheme);
  }
}
