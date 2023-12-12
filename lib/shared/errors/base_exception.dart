import 'package:flutter_dicas_cep_clean_architecture/shared/const/const_strings.dart';

base class BaseException implements Exception {
  final String message;

  const BaseException({String? message})
      : message = message ?? ConstStrings.kDefaultErrorMessage;
}
