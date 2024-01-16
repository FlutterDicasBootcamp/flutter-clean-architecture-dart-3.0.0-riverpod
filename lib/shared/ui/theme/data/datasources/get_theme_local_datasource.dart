import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';

abstract interface class GetThemeLocalDataSource {
  Future<bool> getIsLightTheme();
}

const GET_IS_LIGHT_THEME = 'GET_IS_LIGHT_THEME';

final class GetThemeLocalDataSourceImpl implements GetThemeLocalDataSource {
  final LocalService _localService;

  GetThemeLocalDataSourceImpl(this._localService);

  @override
  Future<bool> getIsLightTheme() async {
    final isLightTheme = await _localService.get<bool>(GET_IS_LIGHT_THEME);

    switch (isLightTheme) {
      case Left():
        {
          return true;
        }
      case Right(value: final r):
        {
          return r ?? true;
        }
    }
  }
}
