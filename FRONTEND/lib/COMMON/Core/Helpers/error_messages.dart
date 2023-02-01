import 'package:health_pulse/imports.dart';
import 'package:dio/dio.dart';

class RegistrationOrLogInErrors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "This e-mail address is already in use, please use a different e-mail address.";

      case 'ERROR_INVALID_EMAIL':
        return "Your email address appears to be malformed.";

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return "The e-mail address in your Facebook account has been registered in the system before. Please login by trying other methods with this e-mail address.";

      case 'ERROR_WRONG_PASSWORD':
        return "E-mail address or password is incorrect.";

      case "ERROR_USER_NOT_FOUND":
        return "User with this email doesn't exist.";

      case "ERROR_USER_DISABLED":
        return  "User with this email has been disabled.";

      case "ERROR_TOO_MANY_REQUESTS":
        return "Too many requests. Try again later.";

      case "ERROR_OPERATION_NOT_ALLOWED":
        return  "Signing in with Email and Password is not enabled.";

      default:
        return "An undefined Error happened.";
    }
  }
}

class ProfileDataFormErrors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return "This e-mail address is already in use, please use a different e-mail address.";
    default:
        return "An undefined Error happened.";
    }
  }
}

/*class ErrorHandlingClass extends Interceptor {
  final Dio ? dio;

  ErrorHandlingClass(this.dio);

  @override
  void onError(DioError ? err, ErrorInterceptorHandler ? handler) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(e.requestOptions);
      case DioErrorType.response:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(e.requestOptions);
          case 401:
            throw UnauthorizedException(e.requestOptions);
          case 404:
            throw NotFoundException(e.requestOptions);
          case 409:
            throw ConflictException(e.requestOptions);
          case 500:
            throw InternalServerErrorException(e.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException(e.requestOptions);
    }

    return handler!.next(e);
  }
}*/

class BadRequestException extends DioError {
  BadRequestException(RequestOptions  r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error, please try again …..';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested info could not be found';
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection found , please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again…..';
  }
}