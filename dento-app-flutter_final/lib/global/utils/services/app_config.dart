// Environment Control

enum Environment {
  staging,
  production,
}

class BuildConfiguration {
  static final shared = BuildConfiguration();

  late Environment environment;

  // Base Url
  String get baseUrl {
    switch (environment) {
      case Environment.staging:
        // return "https://3e4c-2401-4900-1f3f-bad0-44ad-83a4-3841-34db.in.ngrok.io/api/v1/";
        return "https://tsttechnology.in/api/v1";
      case Environment.production:
        return "https://tsttechnology.in/api/v1";
    }
  }

  // Socket Url
  String get socketUrl {
    switch (environment) {
      case Environment.staging:
        return "https://tsttechnology.in/";
      case Environment.production:
        return "https://tsttechnology.in/";
    }
  }

  // Mode
  String get mode {
    switch (environment) {
      case Environment.staging:
        return "TEST";
      case Environment.production:
        return "PROD";
    }
  }
}
