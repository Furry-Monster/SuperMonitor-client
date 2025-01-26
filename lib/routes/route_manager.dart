import 'package:flutter/material.dart';
import 'app_routes.dart';

class RouteManager extends ChangeNotifier {
  int _currentIndex = 0;
  String _currentRoute = AppRoutes.home;

  int get currentIndex => _currentIndex;
  String get currentRoute => _currentRoute;

  void navigateToIndex(int index, BuildContext context) {
    if (index != _currentIndex) {
      _currentIndex = index;
      _currentRoute = AppRoutes.getRouteByIndex(index);
      notifyListeners();
    }
  }

  void navigateToRoute(String route, BuildContext context) {
    if (route != _currentRoute) {
      _currentRoute = route;
      _currentIndex = AppRoutes.getPageIndex(route);
      notifyListeners();
    }
  }
} 