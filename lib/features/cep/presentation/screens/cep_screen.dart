import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/app_bars/cep_screen_app_bar_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/tabs/search_by_cep_tab_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/tabs/search_by_local_details_tab_widget.dart';

class CepScreen extends StatelessWidget {
  const CepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CepScreenScaffoldWidget(
      title: 'Cep App - Clean Architecture',
      tabs: [
        SearchByCepTabWidget(),
        SearchByLocalDetailsTabWidget(),
      ],
    );
  }
}
