import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/repositories/cep_repository.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/cep_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/snack_bar_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class CepNotifier extends StateNotifier<CepState> {
  final CepRepository _cepRepository;

  CepNotifier(this._cepRepository) : super(const CepState.initial());

  bool get isLoading => state.isLoading;

  Future<void> loadAddress(String cep, BuildContext context) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      state: CepStateEnum.loading,
    );

    final cepEither = await _cepRepository(CepBodyModel(cep));

    switch (cepEither) {
      case Left(value: final l):
        {
          final noInternetError = l is CepInternetConnectionException;
          if (noInternetError && context.mounted) {
            context.showSnackBar(SnackBarType.error, l.message);
          }
          state = state.copyWith(
            isLoading: false,
            state: noInternetError ? CepStateEnum.loaded : CepStateEnum.error,
            errorMessage: noInternetError ? null : l.message,
            cep: noInternetError ? l.cep : null,
          );
        }
      case Right(value: final r):
        {
          state = state.copyWith(
            isLoading: false,
            state: CepStateEnum.loaded,
            cep: r,
          );
        }
    }
  }
}
