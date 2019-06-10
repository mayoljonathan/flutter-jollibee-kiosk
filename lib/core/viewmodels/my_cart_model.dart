import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/core/models/cart.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

class MyCartModel extends BaseModel {
  List<MenuItemCart> _items = [];
  List<MenuItemCart> get items => _items;

  void clearCart() {
    _items = [];
    notifyListeners();
  }
}