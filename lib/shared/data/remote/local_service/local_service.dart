import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/errors/local_exception.dart';

abstract interface class LocalService {
  Future<Either<LocalException, T?>> get<T>(String key);

  Future<Either<LocalException, void>> set<T>(String key, T data);
}
