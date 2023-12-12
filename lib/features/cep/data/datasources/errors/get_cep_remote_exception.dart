import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/base_exception.dart';

base class GetCepException extends BaseException {
  GetCepException({super.message});
}

final class GetCepRemoteException extends GetCepException {
  GetCepRemoteException({super.message});
}

final class GetCepInternetConnectionException extends GetCepException {
  final CepResponseModel? cep;

  GetCepInternetConnectionException({this.cep})
      : super(message: 'Sem conexāo. Tente novamente mais tarde.');
}

final class GetCepLocalException extends GetCepException {
  GetCepLocalException({super.message});
}
