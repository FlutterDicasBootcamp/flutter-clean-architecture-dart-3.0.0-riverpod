import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_notifier_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/ui/theme/domain/providers/theme_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Key localDetailsKey = Key('localDetails');

class CepScreenScaffoldWidget extends ConsumerStatefulWidget {
  final String title;
  final List<Widget> tabs;

  const CepScreenScaffoldWidget({
    required this.title,
    required this.tabs,
    super.key,
  });

  @override
  ConsumerState<CepScreenScaffoldWidget> createState() =>
      _CepScreenScaffoldState();
}

class _CepScreenScaffoldState extends ConsumerState<CepScreenScaffoldWidget>
    with TickerProviderStateMixin {
  late TabController tabCtrl;

  @override
  void initState() {
    ref.read<ThemeNotifier>(themeNotifierProvider.notifier).initThemeState();

    tabCtrl = TabController(length: 2, vsync: this)
      ..addListener(onTabIndexChange);
    super.initState();
  }

  void onTabIndexChange() {
    if (tabCtrl.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    tabCtrl.removeListener(onTabIndexChange);
    super.dispose();
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
        bottom: TabBar(
          controller: tabCtrl,
          tabs: const [
            Tab(
              icon: Icon(Icons.search),
              text: 'CEP',
            ),
            Tab(
              key: localDetailsKey,
              icon: Icon(Icons.location_city),
              text: 'Detalhes do local',
            ),
          ],
        ),
        title: Text(widget.title),
      ),
      body: widget.tabs[tabCtrl.index],
    );
  }
}
