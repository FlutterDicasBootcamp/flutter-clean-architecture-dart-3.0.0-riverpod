import 'dart:convert';

final class CepResponseModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  CepResponseModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
  });

  factory CepResponseModel.fromMap(map) {
    // final {
    //   'cep ': cep,
    //   'logradouro': logradouro,
    //   'complemento': complemento,
    //   'bairro': bairro,
    //   'localidade': localidade,
    //   'uf': uf,
    // } = map;
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
  String toString() =>
      'Cep: $cep, Logradouro: $logradouro, Complemento: $complemento, Bairro: $bairro, Localidade: $localidade and UF: $uf';
}
