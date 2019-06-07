import 'package:flutter/material.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/views/entry_view.dart';
import 'package:jollibee_kiosk/ui/views/home_view.dart';
import 'package:jollibee_kiosk/ui/views/item_detail_view.dart';
import 'package:jollibee_kiosk/ui/views/option_item_quantity_picker_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/entry':
        return MaterialPageRoute(builder: (_) => EntryView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/item-detail':
        final item = settings.arguments as MenuItem;
        return HeroDialogRoute(
          builder: (BuildContext context) => ItemDetailView(item: item)
        );
      case '/option-item-quantity-picker':
        final args = settings.arguments as Map<String, dynamic>;
        final optionItem = args['optionItem'] as OptionItem;
        final maxQuantity = args['maxQuantity'] as int;

        return HeroDialogRoute(
          builder: (BuildContext context) => OptionItemQuantityPickerView(
            optionItem: optionItem,
            maxQuantity: maxQuantity,
          )
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