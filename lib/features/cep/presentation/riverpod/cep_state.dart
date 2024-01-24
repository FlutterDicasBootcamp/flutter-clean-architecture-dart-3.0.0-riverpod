import 'package:equatable/equatable.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';

enum CepStateEnum { initial, loading, loaded, error }

final class CepState extends Equatable {
  final CepResponseModel? cep;
  final bool isLoading;
  final CepStateEnum state;
  final String? errorMessage;

  const CepState({
    this.cep,
    this.isLoading = false,
    this.state = CepStateEnum.initial,
    this.errorMessage,
  });

  const CepState.initial({
    this.cep,
    this.isLoading = false,
    this.state = CepStateEnum.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [cep, isLoading, state, errorMessage];

  CepState copyWith({
    CepResponseModel? cep,
    bool? isLoading,
    CepStateEnum? state,
    String? errorMessage,
  }) =>
      CepState(
        cep: cep ?? this.cep,
        isLoading: isLoading ?? this.isLoading,
        state: state ?? this.state,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
