import 'package:flutter_dicas_cep_clean_architecture/shared/domain/models/remote/api_base_model.dart';

final class ApiResponseModel<T> extends ApiBaseModel {
  final T data;

  const ApiResponseModel({
    required this.data,
    super.message,
    required super.statusCode,
  });
}
