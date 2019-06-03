import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_on.g.dart';

@JsonSerializable(nullable: true)
class AddOn {
  String id;
  String name;
  List<AddOnItem> items;

  AddOn({this.id, this.name, this.items});

  factory AddOn.fromJson(Map<String, dynamic> json, { String id }) {
    json['id'] = id;
    json['items'] = (json['items'] as List)?.map((e) => e.cast<String, dynamic>() as Map<String, dynamic>)?.toList();
    return _$AddOnFromJson(json);
  }
  factory AddOn.fromSnapshot(DocumentSnapshot snapshot) => AddOn.fromJson(snapshot.data, id: snapshot.documentID);

}

@JsonSerializable(nullable: true)
class AddOnItem {
  final String id;
  final String name;
  final String image;

  AddOnItem({
    this.id, 
    this.name, 
    this.image, 
  });

  factory AddOnItem.fromJson(Map<String, dynamic> json) => _$AddOnItemFromJson(json);

}