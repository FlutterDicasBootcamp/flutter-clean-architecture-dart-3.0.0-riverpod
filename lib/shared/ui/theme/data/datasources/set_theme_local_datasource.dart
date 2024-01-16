import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/errors/theme_local_exception.dart';

abstract interface class SetThemeLocalDataSource {
  Future<Either<ThemeLocalException, void>> setIsLightTheme(bool isLightTheme);
}

const GET_IS_LIGHT_THEME = 'GET_IS_LIGHT_THEME';

final class SetThemeLocalDataSourceImpl implements SetThemeLocalDataSource {
  final LocalService _localService;

  SetThemeLocalDataSourceImpl(this._localService);

  @override
  Future<Either<ThemeLocalException, void>> setIsLightTheme(
      bool isLightTheme) async {
    final isLightThemeEither =
        await _localService.set<bool>(GET_IS_LIGHT_THEME, isLightTheme);

    switch (isLightThemeEither) {
      case Left():
        {
          return Left(ThemeLocalException(message: 'Error setting theme.'));
        }
      case Right():
        {
          return Right(null);
        }
    }
  }
}
