import 'dart:convert';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/cep_response.dart';

final class CepResponseModel extends CepResponse {
  const CepResponseModel({
    required super.cep,
    required super.logradouro,
    required super.complemento,
    required super.bairro,
    required super.localidade,
    required super.uf,
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

  Map<String, dynamic> toMap() => {
        'cep': cep,
        'logradouro': logradouro,
        'complemento': complemento,
        'bairro': bairro,
        'localidade': localidade,
        'uf': uf
      };

  String toJSON() => jsonEncode(toMap());
}
