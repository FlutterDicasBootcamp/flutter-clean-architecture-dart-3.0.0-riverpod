import 'package:equatable/equatable.dart';

class CepBody extends Equatable {
  final String cep;

  const CepBody(this.cep);

  @override
  List<Object?> get props => [cep];
}
