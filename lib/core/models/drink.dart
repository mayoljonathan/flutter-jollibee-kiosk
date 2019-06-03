import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drink.g.dart';

@JsonSerializable(nullable: true)
class Drink {
  String id;
  String name;
  List<DrinkItem> items;

  Drink({this.id, this.name, this.items});

  factory Drink.fromJson(Map<String, dynamic> json, { String id }) {
    json['id'] = id;
    json['items'] = (json['items'] as List)?.map((e) => e.cast<String, dynamic>() as Map<String, dynamic>)?.toList();
    return _$DrinkFromJson(json);
  }
  factory Drink.fromSnapshot(DocumentSnapshot snapshot) => Drink.fromJson(snapshot.data, id: snapshot.documentID);

}

@JsonSerializable(nullable: true)
class DrinkItem {
  final String id;
  final String name;
  final String image;

  DrinkItem({
    this.id, 
    this.name, 
    this.image, 
  });

  factory DrinkItem.fromJson(Map<String, dynamic> json) => _$DrinkItemFromJson(json);

}