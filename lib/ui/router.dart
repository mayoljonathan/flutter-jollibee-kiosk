import 'package:flutter/material.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/views/entry_view.dart';
import 'package:jollibee_kiosk/ui/views/home_view.dart';
import 'package:jollibee_kiosk/ui/views/item_detail_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/entry':
        return MaterialPageRoute(builder: (_) => EntryView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/item-detail':
        final item = settings.arguments as Item;
        return HeroDialogRoute(
          builder: (BuildContext context) => ItemDetailView(item: item)
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          );
        });
    }
  }
}