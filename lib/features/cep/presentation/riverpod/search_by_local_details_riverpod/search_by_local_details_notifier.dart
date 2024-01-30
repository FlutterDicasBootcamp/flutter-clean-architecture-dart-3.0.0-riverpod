import 'package:flutter/material.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/data_sources/errors/cep_remote_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_local_details_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/use_cases/get_cep_details_by_local_details.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/base_cep_app_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/presentation/riverpod/search_by_local_details_riverpod/search_by_local_details_state.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/extensions/snack_bar_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class SearchByLocalDetailsNotifier
    extends StateNotifier<SearchByLocalDetailsState> {
  final GetCepDetailsByLocalDetails _getCepDetailsByLocalDetails;

  SearchByLocalDetailsNotifier(this._getCepDetailsByLocalDetails)
      : super(const SearchByLocalDetailsState.initial());

  bool get isLoading => state.isLoading;

  Future<void> loadAddressByLocalDetails(
      GetCepDetailsByLocalDetailsBody localDetailsBody,
      BuildContext context) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      state: CepStateEnum.loading,
    );

    final cepEither = await _getCepDetailsByLocalDetails(localDetailsBody);

    switch (cepEither) {
      case Left(value: final l):
        {
          final noInternetError = l is LocalDetailsInternetConnectionException;
          if (noInternetError && context.mounted) {
            context.showSnackBar(SnackBarType.error, l.message);
          }
          state = state.copyWith(
            isLoading: false,
            state: noInternetError ? CepStateEnum.loaded : CepStateEnum.error,
            errorMessage: noInternetError ? null : l.message,
            localDetailsList: noInternetError ? l.cep : null,
          );
        }
      case Right(value: final r):
        {
          state = state.copyWith(
            isLoading: false,
            state: r == null || r.isEmpty
                ? CepStateEnum.noResult
                : CepStateEnum.loaded,
            localDetailsList: r,
          );
        }
    }
  }
}
