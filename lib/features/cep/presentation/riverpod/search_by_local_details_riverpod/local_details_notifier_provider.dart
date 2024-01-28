import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/providers/get_cep_details_provider.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details_by_local_details.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_notifier.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchByLocalDetailsNotifierProvider = StateNotifierProvider<
    SearchByLocalDetailsNotifier, SearchByLocalDetailsState>((ref) {
  final getCepDetailsByLocalDetailsInstance =
      ref.read<GetCepDetailsByLocalDetails>(getCepDetailsByLocalDetails);

  return SearchByLocalDetailsNotifier(
    getCepDetailsByLocalDetailsInstance,
  );
});
