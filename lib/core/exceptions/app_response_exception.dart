import 'package:dento_support/core/exceptions/network_response_exception.dart';

class AppResponseException
    extends NetworkResponseException<Exception, dynamic> {
  AppResponseException({required this.message, required super.exception});

  final String message;
}
