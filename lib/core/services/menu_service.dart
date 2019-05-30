import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';

class MenuService {

  Future<List<Category>> getMenu(context) async {
    print('getting menu!!');
    List<Category> categories = [];
    QuerySnapshot snapshot = await Firestore.instance.collection('categories').getDocuments();
    if (snapshot.documents.isNotEmpty) {
      categories = snapshot.documents.map((DocumentSnapshot doc) => Category.fromSnapshot(doc)).toList();
    }
    return categories;
  }
}