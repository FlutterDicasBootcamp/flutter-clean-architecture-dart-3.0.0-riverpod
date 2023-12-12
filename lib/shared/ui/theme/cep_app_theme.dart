import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/cep_app_colors.dart';

sealed class CepAppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: CepAppColors.primaryColor,
          onPrimary: CepAppColors.primaryColor,
          secondary: CepAppColors.secondaryColor,
          onSecondary: CepAppColors.secondaryColor,
          error: CepAppColors.errorColor,
          onError: CepAppColors.errorColor,
          background: CepAppColors.lightBgColor,
          onBackground: CepAppColors.lightBgColor,
          surface: CepAppColors.lightBgColor,
          onSurface: CepAppColors.lightBgColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: CepAppColors.primaryColor,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black87,
          titleTextStyle: TextStyle(
            color: CepAppColors.secondaryColor,
            fontSize: 18,
          ),
        ),
        scaffoldBackgroundColor: CepAppColors.darkBgColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: CepAppColors.whiteColor,
            fontSize: 14,
          ),
          titleMedium: TextStyle(
            color: CepAppColors.whiteColor,
            fontSize: 20,
          ),
        ),
      );

  static ThemeData get dark => light.copyWith(
        brightness: Brightness.dark,
        colorScheme: light.colorScheme.copyWith(
          background: CepAppColors.darkBgColor,
          onBackground: CepAppColors.darkBgColor,
          surface: CepAppColors.darkBgColor,
          onSurface: CepAppColors.darkBgColor,
        ),
        appBarTheme: light.appBarTheme.copyWith(
          backgroundColor: CepAppColors.primaryColor,
          titleTextStyle: light.appBarTheme.titleTextStyle!.copyWith(
            color: CepAppColors.secondaryColor,
          ),
        ),
        scaffoldBackgroundColor: CepAppColors.secondaryColor,
        textTheme: light.textTheme.copyWith(
          bodyMedium: light.textTheme.bodyMedium!.copyWith(
            color: CepAppColors.blackColor,
          ),
          titleMedium: light.textTheme.titleMedium!.copyWith(
            color: CepAppColors.blackColor,
          ),
        ),
      );
}
