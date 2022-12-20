// Package imports:

import 'package:dio/dio.dart';

import '../../../export.dart';

class NetworkExceptions {
  static String messageData = "";

  static getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return messageData = STRING_requestCancelled.tr;
            case DioErrorType.connectTimeout:
              return messageData = STRING_connectionTimeout.tr;
            case DioErrorType.other:
              List<String> dateParts = error.message.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == STRING_connectionRefused) {
                return messageData = STRING_serverMaintenance.tr;
              } else if (message[0].trim() == STRING_networkUnreachable) {
                return messageData = STRING_networkUnreachable.tr;
              } else if (dateParts[1].trim() == STRING_failedToConnect) {
                return messageData = STRING_internetConnection.tr;
              } else {
                return messageData = dateParts[1];
              }
            case DioErrorType.receiveTimeout:
              return messageData = STRING_timeOut.tr;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 400:
                  try {
                    return messageData = error.response?.data['message'] ??
                        STRING_unexpectedException.tr;
                  } catch (err) {
                    return messageData = STRING_unexpectedException.tr;
                  }
                case 401:
                  // TODO: remove LocalKey_token
                  // storage.remove(LOCALKEY_token);
                  try {
                    return messageData = error.response?.data['message'] ??
                        '';
                  } catch (err) {
                    return messageData = STRING_UnauthorisedException.tr;
                  }
                case 403:
                  // TODO: remove LocalKey_token
                  // storage.remove(LOCALKEY_token);
                  try {
                    return messageData = error.response?.data['message'] ??
                        STRING_UnauthorisedException.tr;
                  } catch (err) {
                    return messageData = STRING_UnauthorisedException.tr;
                  }
                case 404:
                  return messageData = STRING_notFound.tr;
                case 408:
                  return messageData = STRING_requestTimeOut.tr;
                case 500:
                  return messageData = STRING_internalServerError.tr;
                case 503:
                  return messageData = STRING_internetServiceUnavail.tr;
                default:
                  return messageData = STRING_somethingsIsWrong.tr;
              }
            case DioErrorType.sendTimeout:
              return messageData = STRING_timeOut.tr;
          }
        } else if (error is SocketException) {
          return messageData = socketExceptions.tr;
        } else {
          return messageData = STRING_unexpectedException;
        }
      } on FormatException catch (_) {
        return messageData = STRING_formatException.tr;
      } catch (_) {
        return messageData = STRING_unexpectedException;
      }
    } else {
      if (error.toString().contains(STRING_notsubType.tr)) {
        return messageData = STRING_unableToProcessData.tr;
      } else {
        return messageData = STRING_unexpectedException;
      }
    }
  }
}
