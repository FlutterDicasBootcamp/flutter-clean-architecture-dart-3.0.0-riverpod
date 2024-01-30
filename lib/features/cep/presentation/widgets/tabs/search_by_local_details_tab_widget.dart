import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/mixins/local_details_tec_mixin.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/const/validation_messages_const.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/local_details_notifier_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/buttons/cep_button_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/inputs/cep_text_field_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/widgets/no_result_widget/no_result_widget.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/theme_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const searchZipCodeByLocalDetailsButtonKey = Key('searchZipCodeByLocalDetails');
const zipCodeInput = Key('zip-code-input');

class SearchByLocalDetailsTabWidget extends ConsumerStatefulWidget {
  const SearchByLocalDetailsTabWidget({super.key});

  @override
  ConsumerState<SearchByLocalDetailsTabWidget> createState() =>
      _SearchByLocalDetailsTabWidgetState();
}

class _SearchByLocalDetailsTabWidgetState
    extends ConsumerState<SearchByLocalDetailsTabWidget>
    with LocalDetailsTECMixin {
  final cepInputFN = FocusNode();
  final formKey = GlobalKey<FormState>();

  void onSearchByLocalDetails(SearchByLocalDetailsNotifier notifier) {
    if (formKey.currentState!.validate()) {
      notifier.loadAddressByLocalDetails(
          GetCepDetailsByLocalDetailsBody(
            stateTEC.text,
            cityTEC.text,
            streetTEC.text,
          ),
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref
        .watch<SearchByLocalDetailsState>(searchByLocalDetailsNotifierProvider);
    final notifier = ref.watch<SearchByLocalDetailsNotifier>(
        searchByLocalDetailsNotifierProvider.notifier);

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
                CepStateEnum.loaded => Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: state.localDetailsList
                                ?.map((localDetailsItem) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0),
                                      child: Column(
                                        children: [
                                          Text(localDetailsItem.cep),
                                          const SizedBox(height: 8),
                                          Text(localDetailsItem.localidade),
                                          const SizedBox(height: 8),
                                          Text(localDetailsItem.bairro),
                                          const SizedBox(height: 8),
                                          Text(localDetailsItem.uf),
                                          const SizedBox(height: 8),
                                        ],
                                      ),
                                    ))
                                .toList() ??
                            [],
                      ),
                    ),
                  ),
                CepStateEnum.initial => Text(
                    'Insira um Local:',
                    style: context.getTextTheme.titleMedium,
                  ),
                CepStateEnum.noResult => const NoResultWidget(
                    text: 'Sem resultados, tente outro local',
                  ),
              },
              const SizedBox(height: 16),
              CepTextFieldWidget(
                textEC: stateTEC,
                placeholder: 'Estado',
                validator: (String? state) {
                  if (state == null || state.isEmpty) {
                    return ValidationCepMessagesConst.notEmpty('Estado');
                  } else if (state.length > 2) {
                    return ValidationCepMessagesConst.length('Estado', 2);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CepTextFieldWidget(
                textEC: cityTEC,
                placeholder: 'Cidade',
                validator: (String? city) {
                  if (city == null || city.isEmpty) {
                    return ValidationCepMessagesConst.notEmpty('Cidade');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CepTextFieldWidget(
                textEC: streetTEC,
                placeholder: 'Rua',
                validator: (String? state) {
                  if (state == null || state.isEmpty) {
                    return ValidationCepMessagesConst.notEmpty('Rua');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              CepButtonWidget(
                key: searchZipCodeByLocalDetailsButtonKey,
                onPressed: () {
                  if (state.state == CepStateEnum.loading) {
                    return;
                  }
                  FocusScope.of(context).requestFocus(FocusNode());
                  onSearchByLocalDetails(notifier);
                },
                label: 'Procurar',
                focusNode: cepInputFN,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
