import 'package:flutter_dicas_cep_clean_architecture/shared/errors/base_exception.dart';

base class ApiBaseModel extends BaseException {
  final int statusCode;

  const ApiBaseModel({
    super.message,
    required this.statusCode,
  });
}
