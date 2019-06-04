// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OptionCategory _$OptionCategoryFromJson(Map<String, dynamic> json) {
  return OptionCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : OptionItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$OptionCategoryToJson(OptionCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items
    };

OptionItem _$OptionItemFromJson(Map<String, dynamic> json) {
  return OptionItem(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num)?.toDouble());
}

Map<String, dynamic> _$OptionItemToJson(OptionItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'price': instance.price
    };
