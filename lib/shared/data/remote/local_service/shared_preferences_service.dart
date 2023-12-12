import 'dart:developer';

import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/errors/local_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/local_service/local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements LocalService {
  @override
  Future<Either<LocalException, T?>> get<T>(String key) async {
    try {
      final instance = await SharedPreferences.getInstance();

      if (T == String) {
        return Right(instance.getString(key) as T?);
      } else {
        return Right(instance.getBool(key) as T?);
      }
    } catch (error, st) {
      log(
        'Error loading local String:',
        error: error,
        stackTrace: st,
      );
      return Left(const LocalException(
          message: 'Error loading cache. Please, try again later.'));
    }
  }

  @override
  Future<Either<LocalException, void>> set<T>(String key, T data) async {
    try {
      final instance = await SharedPreferences.getInstance();
      if (T == String) {
        await instance.setString(key, data as String);
      } else {
        await instance.setBool(key, data as bool);
      }

      return Right(null);
    } catch (error, st) {
      log(
        'Error setting local String:',
        error: error,
        stackTrace: st,
      );
      return Left(const LocalException(
          message: 'Error setting cache. Please, try again later.'));
    }
  }
}
