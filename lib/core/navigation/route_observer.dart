import 'dart:developer';

import 'package:flutter/material.dart';

class RouteLoggingObserver extends NavigatorObserver {
  final List<Route<dynamic>> _routeStack = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _routeStack.add(route);
    //log('Pushed route: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _routeStack.remove(route);
    //log('Popped route: ${route.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _routeStack.remove(route);
    log('Removed route: ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null && newRoute != null) {
      final index = _routeStack.indexOf(oldRoute);
      if (index != -1) {
        _routeStack[index] = newRoute;
      }
      log('Replaced route: ${oldRoute.settings.name} with ${newRoute.settings.name}');
    } else if (oldRoute != null) {
      _routeStack.remove(oldRoute);
      log('Removed route: ${oldRoute.settings.name}');
    } else if (newRoute != null) {
      _routeStack.add(newRoute);
      log('Added new route: ${newRoute.settings.name}');
    }
  }


}
