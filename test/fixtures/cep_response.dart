import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_body.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';

const Map<String, dynamic> tCepApiResponse = {
  "cep": "01001-000",
  "logradouro": "Praça da Sé",
  "complemento": "lado ímpar",
  "bairro": "Sé",
  "localidade": "São Paulo",
  "uf": "SP",
};

const String tCepLocalResponse =
    '{"cep":"01001-000","logradouro":"Praça da Sé","complemento":"lado ímpar","bairro":"Sé","localidade":"São Paulo","uf":"SP"}';

const tCepObject = CepResponseModel(
  cep: "01001-000",
  logradouro: "Praça da Sé",
  complemento: "lado ímpar",
  bairro: "Sé",
  localidade: "São Paulo",
  uf: "SP",
);

final tCepBodyRight = CepBodyModel('01001-000');

final tCepBodyFail = CepBodyModel('cep');
