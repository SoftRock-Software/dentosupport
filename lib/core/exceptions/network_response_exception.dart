import 'package:dento_support/core/exceptions/network_exception.dart';

/// Response exception.
class NetworkResponseException<OriginalException extends Exception, DataType>
    extends NetworkException<OriginalException> {
  /// Create a new response exception with the specified [statusCode],
  /// original [exception], and response [data].
  NetworkResponseException({
    required super.exception,
    this.statusCode,
    this.data,
  }) : super(
          reason: NetworkExceptionReason.responseError,
        );

  /// Response data, if any.
  final DataType? data;

  /// HTTP status code, if any.
  final int? statusCode;

  /// True if the response contains data.
  bool get hasData => data != null;

  /// If the status code is null, returns false. Otherwise, allows the
  /// given closure [evaluator] to validate the given http integer status code.
  ///
  /// Usage:
  /// ```
  /// final isValid = responseException.validateStatusCode(
  ///   (statusCode) => statusCode >= 200 && statusCode < 300,
  /// );
  /// ```
  bool validateStatusCode(bool Function(int statusCode) evaluator) {
    final statusCode = this.statusCode;
    if (statusCode == null) return false;
    return evaluator(statusCode);
  }
}
