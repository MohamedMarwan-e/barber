import 'package:get_it/get_it.dart';
import '../app/app_cubit/localization_cubit.dart';
import '../app/app_cubit/theme_cubit.dart';

import 'services/api/api_services.dart';
import 'services/hive.dart';


final di = GetIt.instance;

  /// Initializes the application module, including dependency injection.
Future<void> dependencyInjection() async {
  /// Register the HiveLocalStorage singleton
  di.registerSingleton<HiveLocalStorage>(HiveLocalStorage.instance);

  di.registerLazySingleton<LocalizationCubit>(() => LocalizationCubit(di<HiveLocalStorage>()));
  /// ThemeCubit
  di.registerLazySingleton<ThemeCubit>(() => ThemeCubit(di<HiveLocalStorage>()));
  /// Api Services
  di.registerSingleton<ApiServices>(ApiServices());

}