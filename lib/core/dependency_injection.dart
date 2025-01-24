import 'package:barber/features/auth/cubits/otp/otp_cubit.dart';
import 'package:get_it/get_it.dart';
import '../app/app_cubit/localization_cubit.dart';
import '../app/app_cubit/theme_cubit.dart';

import '../features/auth/cubits/login/login_cubit.dart';
import '../features/auth/cubits/sign_up/sign_up_cubit.dart';
import '../features/auth/repo/repo.dart';
import '../features/auth/repo/repo_imlp.dart';
import '../features/home/cubit/home_cubit.dart';
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


  /// Register AuthRepo and its implementation
  di.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(di<ApiServices>()));

  /// Register Cubits
  di.registerLazySingleton<HomeCubit>(() => HomeCubit());

  di.registerFactory<LoginCubit>(() => LoginCubit(di<AuthRepo>()));
  di.registerLazySingleton<SignUpCubit>(() => SignUpCubit(di<AuthRepo>(),di<HiveLocalStorage>()));
  di.registerFactory<OtpCubit>(() => OtpCubit(di<AuthRepo>(),di<HiveLocalStorage>()));

}