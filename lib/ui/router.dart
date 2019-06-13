import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/models/cart.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/views/entry_view.dart';
import 'package:jollibee_kiosk/ui/views/home_view.dart';
import 'package:jollibee_kiosk/ui/views/item_detail_view.dart';
import 'package:jollibee_kiosk/ui/views/option_item_quantity_picker_view.dart';
import 'package:jollibee_kiosk/ui/views/review_order_view.dart';
import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:jollibee_kiosk/ui/widgets/my_order_list.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/entry':
        return MaterialPageRoute(builder: (_) => EntryView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/item-detail':
        final args = settings.arguments as Map<String, dynamic>;
        final heroTag = args['heroTag'] as String;
        final item = args['item'] as MenuItem;

        // Pass this values when updating the menu item from cart
        final isEditing = args['isEditing'] as bool ?? false;
        final quantity = args['quantity'] as int;
        final optionSelections = args['optionSelections'] as Map<ItemOption, List<OptionItemCart>> ?? {
          ItemOption.Drink: [],
          ItemOption.AddOn: [],
        };

        return HeroDialogRoute(
          builder: (BuildContext context) => ItemDetailView(
            heroTag: heroTag,
            item: item,
            quantity: quantity,
            optionSelections: optionSelections,
            isEditing: isEditing,
          )
        );
      case '/option-item-quantity-picker':
        final args = settings.arguments as Map<String, dynamic>;
        final optionItem = args['optionItem'] as OptionItem;
        final initialQuantity = args['initialQuantity'] as int;
        final maxQuantity = args['maxQuantity'] as int;

        return HeroDialogRoute(
          builder: (BuildContext context) => OptionItemQuantityPickerView(
            optionItem: optionItem,
            initialQuantity: initialQuantity,
            maxQuantity: maxQuantity,
          )
        );
      case '/review-order':
        return MaterialPageRoute(builder: (_) => ReviewOrderView());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          );
        });
    }
  }
}