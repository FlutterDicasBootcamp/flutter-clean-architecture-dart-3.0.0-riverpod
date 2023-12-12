import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/data/errors/theme_local_exception.dart';

abstract interface class ThemeRepository {
  Future<bool> getIsLightTheme();

  Future<Either<ThemeLocalException, void>> setIsLightTheme(bool isLightTheme);
}
