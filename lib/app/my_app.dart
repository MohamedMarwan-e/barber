import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/constants.dart';
import '../core/dependency_injection.dart';
import '../core/navigation/routes.dart';
import '../core/services/life_cycle.dart';
import '../theme/my_theme.dart';
import 'app_cubit/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: BlocBuilder<ThemeCubit, ThemeMode>(
            bloc: di<ThemeCubit>(),
            builder: (context, themeMode) {
              return MaterialApp.router(
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                title: appName,
                debugShowCheckedModeBanner: false,
                theme: appTheme(cairo,context: context),
                darkTheme: darkTheme(cairo,context: context),
                themeMode: themeMode,
                routerConfig: Routes.instance.getRoutes(),

                builder: (context, widget) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                        textScaler: const TextScaler.linear(1)
                    ),
                    child: widget!,
                  );
                },
              );
            },
          )
    );
  }
}