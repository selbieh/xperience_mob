import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xperience/model/data/repo/cars_service_repo.dart';
import 'package:xperience/model/data/repo/booking_repo.dart';
import 'package:xperience/model/data/repo/hotels_service_repo.dart';
import 'package:xperience/model/data/repo/info_repo.dart';
import 'package:xperience/model/data/repo/notifications_repo.dart';
import 'package:xperience/model/data/repo/reservations_repo.dart';
import 'package:xperience/model/services/auth/auth_service.dart';
import 'package:xperience/model/services/localization/app_language.dart';
import 'package:xperience/model/services/theme/app_theme.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AppLanguage()),
  ChangeNotifierProvider(create: (_) => AppTheme()),
  ChangeNotifierProvider(create: (_) => AuthService(), lazy: false),
  // --------------------------------------------------------------------
  ChangeNotifierProvider(create: (_) => CarsServiceRepo()),
  ChangeNotifierProvider(create: (_) => HotelsServiceRepo()),
  ChangeNotifierProvider(create: (_) => ReservationRepo()),
  ChangeNotifierProvider(create: (_) => InfoRepo()),
  ChangeNotifierProvider(create: (_) => NotificationsRepo()),
  ChangeNotifierProvider(create: (_) => BookingRepo()),
];
