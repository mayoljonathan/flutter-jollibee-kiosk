import 'package:flutter/widgets.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

class EntryModel extends BaseModel {
  final MenuService _menuService = locator<MenuService>();
  final List<String> _assetImages = [
    'at_counter.png',
    'cashier.png',
    'dine_in.png',
    'jollibee_icon.png',
    'jollibee_logo.png',
    'receipt.png',
    'take_out.png',
  ];

  void getAllMenu(context) async {
    setState(ViewState.Busy);
    try {
      await Future.wait([
        _menuService.getMenu(context),
        _menuService.getDrinks(context),
        _menuService.getAddOns(context)
      ]);

      print('Starting precaching images');
      await _precacheImages(context);
      print('Done precaching images');
      setState(ViewState.Idle);
    } catch (e) {
      print('[getAllMenu]: $e');
      setState(ViewState.Idle);
    }
  }

  Future<void> _precacheImages(context) async {
    return await Future.wait([
      Future.wait(_assetImages.map((String fileName) async {
        await precacheImage(AssetImage('assets/images/$fileName'), context);
      })),
      Future.wait(_menuService.menu.map((Menu menu) async {
        await precacheImage(NetworkImage(menu.image), context);
        if (menu.items != null && menu.items.length > 0) {
          await Future.wait(menu.items.map((MenuItem item) async => await precacheImage(NetworkImage(item.image), context)));
        }
      })),
      Future.wait(_menuService.drinks.map((OptionCategory optionCategory) async {
        if (optionCategory.items != null && optionCategory.items.length > 0) {
          await Future.wait(optionCategory.items.map((OptionItem item) async => await precacheImage(NetworkImage(item.image), context)));
        }
      })),
      Future.wait(_menuService.addOns.map((OptionCategory optionCategory) async {
        if (optionCategory.items != null && optionCategory.items.length > 0) {
          await Future.wait(optionCategory.items.map((OptionItem item) async => await precacheImage(NetworkImage(item.image), context)));
        }
      }))
    ]);
  }

}