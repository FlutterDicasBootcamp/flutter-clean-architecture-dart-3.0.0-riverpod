import 'package:flutter_dicas_cep_clean_architecture/shared/errors/base_exception.dart';

final class ThemeLocalException extends BaseException {
  ThemeLocalException({String? message}) : super(message: message);
}
