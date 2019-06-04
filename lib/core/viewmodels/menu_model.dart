import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

class MenuModel extends BaseModel {
  MenuService _menuService = locator<MenuService>();

  Menu _selectedMenu;
  Menu get selectedMenu => _selectedMenu;
  set selectedMenu(Menu menu) {
    _selectedMenu = menu;
    notifyListeners();
  }

  List<OptionCategory> getDrinks() => _menuService.drinks;
  List<OptionCategory> getAddOns() => _menuService.addOns;

  void setInitialSelectedMenu(context) {
    _selectedMenu = Provider.of<List<Menu>>(context, listen: false).first;
  }

  bool isSelectedMenu(String id) => _selectedMenu?.id == id;
}