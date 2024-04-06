import 'package:dento_support/core/exceptions/client_exception.dart';

/// Reason for a network exception.
enum NetworkExceptionReason {
  /// A request cancellation is responsible for the exception.
  canceled,

  /// A timeout error is responsible for the exception.
  timedOut,

  /// A response error is responsible for the exception.
  responseError
}

/// Network error.
class NetworkException<OriginalException extends Exception>
    extends ClientException<OriginalException> {
  /// Create a network exception.
  NetworkException({
    required this.reason,
    required super.exception,
  });

  /// The reason the network exception ocurred.
  final NetworkExceptionReason reason;
}
