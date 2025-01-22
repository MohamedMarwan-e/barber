import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dependency_injection.dart';
import '../services/hive.dart';
import 'app_log.dart';
import 'bloc_observer.dart';


Future<void> initializeApp() async {
  try {
    await Future.wait([
      EasyLocalization.ensureInitialized(),
      HiveLocalStorage.instance.init(),
      dependencyInjection(),
    ]);

    Bloc.observer = CustomBlocObserver();
    AppLogs().successLog('App initialized successfully.');
  } catch (error) {
    AppLogs().errorLog('Error during app initialization: $error');
  }
}