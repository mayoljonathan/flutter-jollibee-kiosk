import 'package:jollibee_kiosk/service_locator.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

class EntryModel extends BaseModel {
  final MenuService _menuService = locator<MenuService>();

  Future<List<Category>> getMenu(context) async {
    setState(ViewState.Busy);

    List<Category> _categories = await _menuService.getMenu(context);
    print('here cat');
    print(_categories);
    setState(ViewState.Idle);
    return _categories;
  }


}