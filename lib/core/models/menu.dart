import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String id;
  String name;
  String image;
  List<Item> items;
  // DocumentReference reference;

  Menu.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    image = data['image'];

    if (data['items'] != null) {
    print('this');
    items = data['items'].map<Item>((e) {
      // print(e);
      return Item.fromJson(e);
    }).toList();

    print(items);

    }
    // items = data['items']?.cast<Item>();
  }

  Menu.fromSnapshot(DocumentSnapshot snapshot) : this.fromJson(snapshot.data);

  // Menu.fromJson(Map<String, dynamic> data, {this.id, this.reference})
  //   : assert(data['name'] != null),
  //     assert(data['image'] != null),
  //     name = data['name'],
  //     image = data['image'],
  //     // items = data['items']?.cast<Item>(); // ERROR
  //     items = [];
      // items = data['items']?.cast<Item>()?.map<Item>((item) => Item.fromJson(item));

    // items = List<Item>.from(data['items'].map((i) => Item.fromMap(i)));

  // Menu.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromJson(snapshot.data, id: snapshot.documentID, reference: snapshot.reference);
}

class Item {
  String id;
  String name;
  String image;
  double price;
  // final DocumentReference reference;

  Item.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    price = data['price'];
    // items = data['items']?.cast<Item>();
  }

  // Item.fromJson(Map<String, dynamic> map, {this.id, this.reference})
  //   : assert(map['name'] != null),
  //     assert(map['image'] != null),
  //     assert(map['price'] != null),
  //     name = map['name'],
  //     image = map['image'],
  //     price = map['price'];

  // Item.fromSnapshot(DocumentSnapshot snapshot)
  //     : this.fromJson(snapshot.data, id: snapshot.documentID, reference: snapshot.reference);

}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'menu.g.dart';

// @JsonSerializable(nullable: true)
// class Menu {

//   final String id;
//   final String name;
//   final String image;
//   final List<Item> items;
//   // final dynamic reference;

//   Menu({this.id, this.name, this.image, this.items});

//   factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

// }

// @JsonSerializable(nullable: true)
// class Item {
//   final String id;
//   final String name;
//   final String image;
//   final double price;
//   // final dynamic reference;

//   Item({
//     this.id, 
//     this.name, 
//     this.image, 
//     this.price, 
//     // this.reference
//   });

//   factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

// }