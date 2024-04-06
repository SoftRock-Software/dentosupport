class ClientException<OriginalException extends Exception>
    implements Exception {
  /// Create a new application http client exception with the specified
  /// underlying [exception].
  ClientException({required this.exception});

  /// Exception which was caught.
  final OriginalException exception;
}
