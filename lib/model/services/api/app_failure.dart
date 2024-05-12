enum AppFailureType {
  timeout,
  socket,
  http,
  format,
  error,
  other,
}

class AppFailure {
  AppFailure({required this.message});
  final String message;

  static String getMessage(AppFailureType type) {
    switch (type) {
      case AppFailureType.timeout:
        return "Please check your network connection";
      case AppFailureType.socket:
        return "You have no internet connection";
      case AppFailureType.http:
        return "You have HTTP exception error";
      case AppFailureType.format:
        return "You have Format exception error, try check response data";
      case AppFailureType.error:
        return "You have failure error";
      case AppFailureType.other:
        return "Something went wrong";
    }
  }
}

class ApiFailure extends AppFailure {
  ApiFailure({
    required super.message,
    this.statusCode = 000,
  });

  final int? statusCode;
}

class TimeoutFailure extends AppFailure {
  TimeoutFailure({required super.message});
}

class SocketFailure extends AppFailure {
  SocketFailure({required super.message});
}

class HttpFailure extends AppFailure {
  HttpFailure({required super.message});
}

class FormatFailure extends AppFailure {
  FormatFailure({required super.message});
}

class ErrorFailure extends AppFailure {
  ErrorFailure({required super.message});
}

class OtherFailure extends AppFailure {
  OtherFailure({required super.message});
}
