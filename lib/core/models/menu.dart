import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  final String documentID;
  final String name;
  final String image;
  final DocumentReference reference;

  Menu.fromMap(Map<String, dynamic> map, {this.documentID, this.reference})
    : assert(map['name'] != null),
      assert(map['image'] != null),
      name = map['name'],
      image = map['image'];

  Menu.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, documentID: snapshot.documentID, reference: snapshot.reference);
}