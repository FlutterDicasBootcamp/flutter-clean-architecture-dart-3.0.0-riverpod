import 'package:equatable/equatable.dart';

class GetCepDetailsByLocalDetailsBody extends Equatable {
  final String estado;
  final String cidade;
  final String rua;

  const GetCepDetailsByLocalDetailsBody(this.estado, this.cidade, this.rua);

  @override
  List<Object?> get props => [estado, cidade, rua];
}
