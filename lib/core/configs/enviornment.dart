abstract class Enviorment {
  String get baseUrl;
}

class LiveEnviormentImpl implements Enviorment {
  @override
  String get baseUrl => 'https://backend.dentosupport.com/api/v1';
}

class StageEnviormentImpl implements Enviorment {
  @override
  String get baseUrl => 'https://staging.dentosupport.com/api/v1';
}
