// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_on.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddOn _$AddOnFromJson(Map<String, dynamic> json) {
  return AddOn(
      id: json['id'] as String,
      name: json['name'] as String,
      items: (json['items'] as List)
          ?.map((e) =>
              e == null ? null : AddOnItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AddOnToJson(AddOn instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items
    };

AddOnItem _$AddOnItemFromJson(Map<String, dynamic> json) {
  return AddOnItem(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$AddOnItemToJson(AddOnItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image
    };
