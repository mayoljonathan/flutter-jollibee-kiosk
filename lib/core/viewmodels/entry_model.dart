import 'package:jollibee_kiosk/locator.dart';

import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

class EntryModel extends BaseModel {
  final MenuService _menuService = locator<MenuService>();

  void getAllMenu(context) async {
    setState(ViewState.Busy);
    try {
      await Future.wait([
        _menuService.getMenu(context),
        _menuService.getDrinks(context),
        _menuService.getAddOns(context)
      ]);
      setState(ViewState.Idle);
    } catch (e) {
      print('[getAllMenu]: $e');
      setState(ViewState.Idle);
    }
  }

}