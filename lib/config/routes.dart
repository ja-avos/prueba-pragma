import 'package:flutter/material.dart';
import 'package:prueba_pragma/Cats/models/cat_model.dart';
import 'package:prueba_pragma/Cats/screens/detail_screen.dart';
import 'package:prueba_pragma/Cats/screens/list_screen.dart';

/// Routing of the application
class AppRouter {
  static const String home = '/';
  static const String catDetail = '/detail';

  static Widget getRoute(RouteSettings settings) {
    switch (settings.name) {
      case catDetail:
        return DetailScreen(
          cat: settings.arguments as Cat,
        );
      default:
        return const ListScreen();
    }
  }
}
