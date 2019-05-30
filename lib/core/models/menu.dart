import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  // String id;
  String name;
  String image;
  final DocumentReference reference;

  Category.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['name'] != null),
       assert(map['image'] != null),
       name = map['name'],
       image = map['image'];

  Category.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}