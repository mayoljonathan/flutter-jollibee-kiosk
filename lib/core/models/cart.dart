import 'package:jollibee_kiosk/core/models/base_item.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';

class OptionItemCart extends BaseItem {
  String id;
  String name;
  int quantity;
  double price;

  OptionItemCart({this.id, this.name, this.quantity, this.price});
}

class MenuItemCart {
  final String id;
  final int quantity;
  final MenuItem menuItem;
  final List<OptionItemCart> drinks;
  final List<OptionItemCart> addOns;

  MenuItemCart({
    this.id,
    this.quantity,
    this.menuItem,
    this.drinks,
    this.addOns
  });
}