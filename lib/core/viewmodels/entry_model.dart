import 'package:jollibee_kiosk/locator.dart';

import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

class EntryModel extends BaseModel {
  final MenuService _menuService = locator<MenuService>();

  void getMenu(context) async {
    setState(ViewState.Busy);
    try {
      await _menuService.getMenu(context);
      setState(ViewState.Idle);
    } catch (e) {
      print('[getMenu]: $e');
      setState(ViewState.Idle);
    }
  }

}