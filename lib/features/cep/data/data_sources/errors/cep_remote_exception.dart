import 'package:flutter_dicas_cep_clean_architecture/features/cep/domain/models/cep_response_model.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/base_exception.dart';

base class CepException extends BaseException {
  CepException({super.message});
}

final class CepRemoteException extends CepException {
  CepRemoteException({super.message});
}

final class CepInternetConnectionException extends CepException {
  final CepResponseModel? cep;

  CepInternetConnectionException({this.cep})
      : super(message: 'Sem conexāo. Tente novamente mais tarde.');
}

final class CepLocalException extends CepException {
  CepLocalException({super.message});
}
