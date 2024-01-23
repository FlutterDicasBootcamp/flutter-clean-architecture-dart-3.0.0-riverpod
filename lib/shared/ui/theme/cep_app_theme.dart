import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/cep_app_colors.dart';

sealed class CepAppTheme {
  static ThemeData get light => ThemeData(
        brightness: Brightness.light,
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
          fillColor: CepAppColors.lightBgColor,
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
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
          ),
        ),
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all(Colors.white),
          thumbColor: MaterialStatePropertyAll(
            CepAppColors.primaryColor,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: CepAppColors.primaryColor,
          titleTextStyle: TextStyle(
            color: CepAppColors.secondaryColor,
            fontSize: 18,
          ),
        ),
        scaffoldBackgroundColor: CepAppColors.secondaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: CepAppColors.blackColor,
            fontSize: 14,
          ),
          titleMedium: TextStyle(
            color: CepAppColors.blackColor,
            fontSize: 20,
          ),
        ),
      );

  static ThemeData get dark => light.copyWith(
        appBarTheme: light.appBarTheme.copyWith(
          backgroundColor: Colors.black87,
          titleTextStyle: light.appBarTheme.titleTextStyle!.copyWith(
            color: CepAppColors.secondaryColor,
          ),
        ),
        scaffoldBackgroundColor: CepAppColors.darkBgColor,
        brightness: Brightness.dark,
        colorScheme: light.colorScheme.copyWith(
          brightness: Brightness.dark,
          background: CepAppColors.darkBgColor,
          onBackground: CepAppColors.darkBgColor,
          surface: CepAppColors.darkBgColor,
          onSurface: CepAppColors.darkBgColor,
        ),
        textTheme: light.textTheme.copyWith(
          bodyMedium: light.textTheme.bodyMedium!.copyWith(
            color: CepAppColors.whiteColor,
          ),
          titleMedium: light.textTheme.titleMedium!.copyWith(
            color: CepAppColors.whiteColor,
          ),
        ),
        inputDecorationTheme: light.inputDecorationTheme.copyWith(
          fillColor: CepAppColors.blackColor,
        ),
      );
}
