import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'option_category.g.dart';

@JsonSerializable(nullable: true)
class OptionCategory {
  String id;
  String name;
  List<OptionItem> items;

  OptionCategory({this.id, this.name, this.items});

  factory OptionCategory.fromJson(Map<String, dynamic> json, { String id }) {
    json['id'] = id;
    json['items'] = (json['items'] as List)?.map((e) => e.cast<String, dynamic>() as Map<String, dynamic>)?.toList();
    return _$OptionCategoryFromJson(json);
  }
  factory OptionCategory.fromSnapshot(DocumentSnapshot snapshot) => OptionCategory.fromJson(snapshot.data, id: snapshot.documentID);
}

// Usable both add_on and drink
@JsonSerializable(nullable: true)
class OptionItem {
  final String id;
  final String name;
  final String image;
  final double price;

  OptionItem({
    this.id, 
    this.name, 
    this.image,
    this.price 
  });

  factory OptionItem.fromJson(Map<String, dynamic> json) => _$OptionItemFromJson(json);

}