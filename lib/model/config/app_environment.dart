enum EnvironmentType {
  development,
  staging,
  production,
}

class AppEnvironment {
  AppEnvironment._internal();
  static final AppEnvironment instance = AppEnvironment._internal();
  EnvironmentType environment = EnvironmentType.production;

  static initialize(EnvironmentType environment) {
    instance.environment = environment;
  }

  String get appName => "${appNamesMap[environment]}";
  String get serverURL => "${serverURLsMap[environment]}";

  final appNamesMap = {
    EnvironmentType.development: "MyTemp Development",
    EnvironmentType.staging: "MyTemp Staging",
    EnvironmentType.production: "MyTemp",
  };
  final serverURLsMap = {
    // EnvironmentType.development: "https://impressive-domini-royals-1be52931.koyeb.app",
    EnvironmentType.development: "https://api.xperiences.vip",
    EnvironmentType.staging: "",
    EnvironmentType.production: "",
  };
}

// *** To add empty string if app is not in "Development" Environment ***
extension DevString on String {
  String get dev {
    // return kDebugMode ? this : null;
    return AppEnvironment.instance.environment != EnvironmentType.development ? "" : this;
  }
}
