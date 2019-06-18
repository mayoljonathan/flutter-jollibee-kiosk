import 'package:json_annotation/json_annotation.dart';

import 'package:jollibee_kiosk/core/models/base_item.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';

part 'cart.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class OptionItemCart extends BaseItem {
  String id;
  String name;
  int quantity;
  double price;

  OptionItemCart({this.id, this.name, this.quantity, this.price});

  Map<String, dynamic> toJson() => _$OptionItemCartToJson(this);
  factory OptionItemCart.fromJson(Map<String, dynamic> json) => _$OptionItemCartFromJson(json);
}

@JsonSerializable(nullable: false, explicitToJson: true)
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

  Map<String, dynamic> toJson() => _$MenuItemCartToJson(this);
  factory MenuItemCart.fromJson(Map<String, dynamic> json) => _$MenuItemCartFromJson(json);
}