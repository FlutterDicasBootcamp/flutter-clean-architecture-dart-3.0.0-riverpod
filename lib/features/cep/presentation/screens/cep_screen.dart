import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/const/validation_messages_const.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/mixins/cep_tec_mixin.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_notifier_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/cep_screen_app_bar.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/theme_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CepScreen extends ConsumerWidget with CepTECMixin {
  CepScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch<CepState>(cepNotifierProvider);
    final notifier = ref.watch<CepNotifier>(cepNotifierProvider.notifier);

    return CepScreenScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: notifier.formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                switch (state.state) {
                  CepStateEnum.error => Text(state.errorMessage!),
                  CepStateEnum.loading => const CircularProgressIndicator(),
                  CepStateEnum.loaded => Column(
                      children: [
                        Text(state.cep!.cep),
                        const SizedBox(height: 8),
                        Text(state.cep!.localidade),
                        const SizedBox(height: 8),
                        Text(state.cep!.bairro),
                        const SizedBox(height: 8),
                        Text(state.cep!.uf),
                        const SizedBox(height: 8),
                      ],
                    ),
                  CepStateEnum.initial => Text(
                      'Insira um CEP:',
                      style: context.getTextTheme.titleMedium,
                    ),
                },
                const SizedBox(height: 16),
                TextFormField(
                  controller: cepTEC,
                  validator: (String? cep) {
                    if (cep == null || cep.isEmpty) {
                      return ValidationCepMessagesConst.notEmpty;
                    } else if (int.tryParse(cep) == null) {
                      return ValidationCepMessagesConst.notValid;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => notifier.loadAddress(cepTEC.text, context),
                  child: Text(
                    'Procurar cep',
                    style: context.getTextTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
