import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/mixins/cep_tec_mixin.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/const/validation_messages_const.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_cep_riverpod/cep_notifier_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_cep_riverpod/search_by_cep_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/buttons/cep_button_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/inputs/cep_text_field_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/no_result_widget/no_result_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/theme_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const searchZipCodeKey = Key('search-zip-code-key');
const zipCodeInput = Key('zip-code-input');

class SearchByCepTabWidget extends ConsumerStatefulWidget {
  const SearchByCepTabWidget({super.key});

  @override
  ConsumerState<SearchByCepTabWidget> createState() =>
      _SearchByCepTabWidgetState();
}

class _SearchByCepTabWidgetState extends ConsumerState<SearchByCepTabWidget>
    with CepTECMixin {
  final cepInputFN = FocusNode();
  final formKey = GlobalKey<FormState>();

  void onSearchCep(SearchByCepNotifier notifier) {
    if (formKey.currentState!.validate()) {
      notifier.loadAddressByCep(cepTEC.text, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch<SearchByCepState>(searchByCepNotifierProvider);
    final notifier =
        ref.watch<SearchByCepNotifier>(searchByCepNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
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
                CepStateEnum.noResult => const NoResultWidget(
                    text: 'Sem resultados, tente outro CEP',
                  ),
              },
              const SizedBox(height: 16),
              CepTextFieldWidget(
                textEC: cepTEC,
                placeholder: 'CEP',
                validator: (String? cep) {
                  if (cep == null || cep.isEmpty) {
                    return ValidationCepMessagesConst.notEmpty('CEP');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              CepButtonWidget(
                key: searchZipCodeKey,
                onPressed: () {
                  if (state.state == CepStateEnum.loading) {
                    return;
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                  onSearchCep(notifier);
                },
                label: 'Procurar',
                focusNode: cepInputFN,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
