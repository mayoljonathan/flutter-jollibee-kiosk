import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';
import 'package:provider/provider.dart';

class MenuModel extends BaseModel {
  Menu _selectedMenu;
  Menu get selectedMenu => _selectedMenu;
  set selectedMenu(Menu menu) {
    _selectedMenu = menu;
    notifyListeners();
  }

  void setInitialSelectedMenu(context) {
    _selectedMenu = Provider.of<List<Menu>>(context, listen: false).first;
  }

  bool isSelectedMenu(String id) => _selectedMenu?.id == id;
}