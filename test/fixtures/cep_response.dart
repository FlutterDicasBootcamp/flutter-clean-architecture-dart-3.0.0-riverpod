import 'package:flutter_dicas_cep_clean_architecture/features/cep/data/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/entities/get_cep_details_by_cep_body.dart';

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

const tGetCepDetailsByCepBodyRight = GetCepDetailsByCepBody('01001-000');

const tGetCepDetailsByCepBodyFail = GetCepDetailsByCepBody('cep');
