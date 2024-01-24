import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/providers/get_cep_details_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cepNotifierProvider = StateNotifierProvider<CepNotifier, CepState>((ref) {
  final getCepDetailsInstance = ref.watch<GetCepDetails>(getCepDetails);

  return CepNotifier(getCepDetailsInstance);
});
