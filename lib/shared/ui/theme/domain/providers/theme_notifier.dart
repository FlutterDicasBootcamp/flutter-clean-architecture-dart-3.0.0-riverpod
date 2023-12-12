import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/snack_bar_extension.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/repositories/theme_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  final ThemeRepository _themeRepository;

  ThemeNotifier(this._themeRepository)
      : super(const ThemeState(themeStateEnum: ThemeStateEnum.light));

  void changeTheme(BuildContext context) async {
    toggleTheme();

    final setIsLightThemeEither = await _themeRepository
        .setIsLightTheme(state.themeStateEnum == ThemeStateEnum.light);

    switch (setIsLightThemeEither) {
      case Left():
        {
          if (context.mounted) {
            context.showSnackBar(SnackBarType.error, 'Error changing Theme');
            toggleTheme();
          }
        }
      case Right():
        {}
    }
  }

  void toggleTheme() {
    state = ThemeState(
        themeStateEnum: state.themeStateEnum == ThemeStateEnum.dark
            ? ThemeStateEnum.light
            : ThemeStateEnum.dark);
  }

  Future<void> initThemeState() async {
    final isLightTheme = await _themeRepository.getIsLightTheme();

    state = ThemeState(
      themeStateEnum: isLightTheme ? ThemeStateEnum.light : ThemeStateEnum.dark,
    );
  }
}
