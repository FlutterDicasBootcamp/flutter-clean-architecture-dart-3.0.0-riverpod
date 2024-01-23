import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_notifier_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CepScreenScaffold extends ConsumerStatefulWidget {
  final String title;
  final Widget body;

  const CepScreenScaffold({required this.title, required this.body, super.key});

  @override
  ConsumerState<CepScreenScaffold> createState() => _CepScreenScaffoldState();
}

class _CepScreenScaffoldState extends ConsumerState<CepScreenScaffold> {
  @override
  void initState() {
    ref.read<ThemeNotifier>(themeNotifierProvider.notifier).initThemeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch<ThemeState>(themeNotifierProvider);
    final themeNotifier =
        ref.watch<ThemeNotifier>(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch.adaptive(
            value: themeState.getTheme == ThemeMode.dark,
            onChanged: (_) => themeNotifier.changeTheme(context),
          )
        ],
        title: Text(widget.title),
      ),
      body: widget.body,
    );
  }
}
