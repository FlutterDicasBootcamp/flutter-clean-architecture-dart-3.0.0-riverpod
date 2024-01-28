import 'package:equatable/equatable.dart';

class GetCepDetailsByCepBody extends Equatable {
  final String cep;

  const GetCepDetailsByCepBody(this.cep);

  @override
  List<Object?> get props => [cep];
}
