import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/const/const_strings.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/api_service.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/api_service/errors/api_exception.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/data/remote/async/either.dart';
import 'package:flutter_dicas_cep_clean_architecture/shared/domain/models/remote/api_response_model.dart';

final class DioService implements ApiService {
  final Dio _dio;

  DioService(this._dio);

  @override
  Future<Either<ApiException, ApiResponseModel>> get(String endPoint) async {
    try {
      final Response(:data, :statusCode, :statusMessage) =
          await _dio.get(endPoint);

      return Right(ApiResponseModel(
        data: data,
        statusCode: statusCode ?? 0,
        message: statusMessage ?? data?['message'] ?? '',
      ));
    } on SocketException catch (socketError, st) {
      const identifier = 'Socket Exception on Get Request';
      log(identifier, error: socketError, stackTrace: st);
      return Left(ApiException(
        identifier: identifier,
        statusCode: 1,
        message: "Você está sem conexāo",
        errorStatus: ErrorStatus.noConnection,
      ));
    } on DioException catch (dioError, st) {
      const identifier = 'DioException on Get Request';
      log(identifier, error: dioError, stackTrace: st);
      return Left(
        ApiException(
            identifier: identifier,
            statusCode: dioError.response?.statusCode ?? 2,
            message: dioError.message ??
                dioError.response?.data?['message'] ??
                ConstStrings.kDefaultErrorMessage,
            errorStatus: dioError.type == DioExceptionType.connectionError
                ? ErrorStatus.noConnection
                : switch (dioError.response?.statusCode) {
                    400 => ErrorStatus.badRequest,
                    500 => ErrorStatus.internalServerError,
                    401 || 403 => ErrorStatus.unauthorized,
                    _ => ErrorStatus.unknown,
                  }),
      );
    } catch (e, st) {
      const identifier = 'GenericException on Get Request';
      log(identifier, error: e, stackTrace: st);
      return Left(
        ApiException(
          identifier: identifier,
          statusCode: 3,
          message: ConstStrings.kDefaultErrorMessage,
          errorStatus: ErrorStatus.unknown,
        ),
      );
    }
  }
}
