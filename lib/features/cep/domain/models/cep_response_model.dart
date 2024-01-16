import 'dart:convert';

import 'package:equatable/equatable.dart';

final class CepResponseModel extends Equatable {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  const CepResponseModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  factory CepResponseModel.fromMap(map) {
    return CepResponseModel(
      cep: map['cep'],
      logradouro: map['logradouro'],
      complemento: map['complemento'],
      bairro: map['bairro'],
      localidade: map['localidade'],
      uf: map['uf'],
    );
  }

  factory CepResponseModel.fromJSON(String json) =>
      CepResponseModel.fromMap(jsonDecode(json));

  String toJSON() => jsonEncode({
        'cep': cep,
        'logradouro': logradouro,
        'complemento': complemento,
        'bairro': bairro,
        'localidade': localidade,
        'uf': uf
      });

  @override
  List<Object?> get props =>
      [cep, logradouro, complemento, bairro, localidade, uf];
}
