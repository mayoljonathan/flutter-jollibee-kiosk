import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'menu.g.dart';

@JsonSerializable(nullable: true)
class Menu {

  String id;
  String name;
  String image;
  List<Item> items;

  Menu({this.id, this.name, this.image, this.items});

  factory Menu.fromJson(Map<String, dynamic> json, { String id }) {
    json['id'] = id;
    json['items'] = (json['items'] as List)?.map((e) => e.cast<String, dynamic>() as Map<String, dynamic>)?.toList();
    return _$MenuFromJson(json);
  }
  factory Menu.fromSnapshot(DocumentSnapshot snapshot) => Menu.fromJson(snapshot.data, id: snapshot.documentID);

}

@JsonSerializable(nullable: true)
class Item {
  final String id;
  final String name;
  final String image;
  final double price;
  final bool hasDrinks;
  final bool hasAddOns;

  Item({
    this.id, 
    this.name, 
    this.image, 
    this.price, 
    this.hasDrinks,
    this.hasAddOns
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  String priceToString() {
    final formatter = NumberFormat.simpleCurrency(name: '', decimalDigits: 2);
    return '₱ ${formatter.format(price)}';
  }

}