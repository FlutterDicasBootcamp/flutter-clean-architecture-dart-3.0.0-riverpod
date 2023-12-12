import 'package:flutter_dicas_cep_clean_architecture/shared/const/const_strings.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/errors/base_exception.dart';

final class NoInternetException extends BaseException {
  NoInternetException(
      {super.message = ConstStrings.kNoInternetConnectionMessage});
}
