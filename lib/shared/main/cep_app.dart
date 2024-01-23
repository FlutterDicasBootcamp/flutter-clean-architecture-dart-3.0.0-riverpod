import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/screens/cep_screen.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/cep_app_theme.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_notifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/theme/domain/cep_config.dart';

class CepApp extends StatelessWidget {
  const CepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (_, ref, __) => MaterialApp(
          title: CepConfig.title,
          theme: CepAppTheme.light,
          darkTheme: CepAppTheme.dark,
          themeMode: ref.watch(themeNotifierProvider).getTheme,
          home: const CepScreen(),
        ),
      ),
    );
  }
}
