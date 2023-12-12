import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/providers/cep_repository_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cepNotifierProvider = StateNotifierProvider<CepNotifier, CepState>((ref) {
  final repository = ref.watch<CepRepository>(cepRepository);

  return CepNotifier(repository);
});
