// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drink.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drink _$DrinkFromJson(Map<String, dynamic> json) {
  return Drink(
      id: json['id'] as String,
      name: json['name'] as String,
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : DrinkItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$DrinkToJson(Drink instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items
    };

DrinkItem _$DrinkItemFromJson(Map<String, dynamic> json) {
  return DrinkItem(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$DrinkItemToJson(DrinkItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image
    };
