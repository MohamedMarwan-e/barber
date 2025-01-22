import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/app_cubit/localization_cubit.dart';
import 'app/my_app.dart';
import 'core/dependency_injection.dart';
import 'core/utils/initialize_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(
      BlocBuilder(
        bloc: di<LocalizationCubit>(),
        builder: (context, locale) {
          return EasyLocalization(
              useOnlyLangCode: true,
              useFallbackTranslations: true,
              startLocale: Locale('ar'),
              supportedLocales: [ Locale('en'), Locale('ar')],
              path: 'assets/translations',
              fallbackLocale: Locale('ar'),
              child: const MyApp()
          );
        },
      )
  );
}