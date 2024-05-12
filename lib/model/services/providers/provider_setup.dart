import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xperience/model/services/api/http_api.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_theme.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HttpApi());
  locator.registerLazySingleton(() => AuthService());
}

// AuthService auth = locator<AuthService>();
// HttpService api = locator<HttpService>();
HttpApi api = locator<HttpApi>();

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AppLanguage()),
  ChangeNotifierProvider(create: (_) => AppTheme()),
  ChangeNotifierProvider(create: (_) => AuthService(), lazy: false),
];
