// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionItemCart _$OptionItemCartFromJson(Map<String, dynamic> json) {
  return OptionItemCart(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble());
}

Map<String, dynamic> _$OptionItemCartToJson(OptionItemCart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price
    };

MenuItemCart _$MenuItemCartFromJson(Map<String, dynamic> json) {
  return MenuItemCart(
      id: json['id'] as String,
      quantity: json['quantity'] as int,
      menuItem: MenuItem.fromJson(json['menuItem'] as Map<String, dynamic>),
      drinks: (json['drinks'] as List)
          .map((e) => OptionItemCart.fromJson(e as Map<String, dynamic>))
          .toList(),
      addOns: (json['addOns'] as List)
          .map((e) => OptionItemCart.fromJson(e as Map<String, dynamic>))
          .toList());
}

Map<String, dynamic> _$MenuItemCartToJson(MenuItemCart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'menuItem': instance.menuItem.toJson(),
      'drinks': instance.drinks.map((e) => e.toJson()).toList(),
      'addOns': instance.addOns.map((e) => e.toJson()).toList()
    };
