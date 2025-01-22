import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

class Routes {
  Routes._internal();
  static final Routes _singleton = Routes._internal();
  static Routes get instance => _singleton;

  GoRouter? _router;
  GoRouter get router {
    _assertRouterInit();
    return _router!;
  }

  void _assertRouterInit() {
    assert(_router != null, 'getRoutes was not called in tree yet');
  }

  GlobalKey<NavigatorState> get navigatorKey {
    _assertRouterInit();
    return _router!.routerDelegate.navigatorKey;
  }

  GoRouter getRoutes({ String? initialLocation}) {
    final routing =  AppRouter();

    _router ??= routing.getRouter(
      initialLocation: initialLocation,
    );
    return _router!;
  }

}
