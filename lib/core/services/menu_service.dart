import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';

class MenuService {
  StreamController<List<Menu>> menuController = StreamController<List<Menu>>();

  Future<List<Menu>> getMenu(context) async {
    List<Menu> menus = [];
    QuerySnapshot snapshot = await Firestore.instance.collection('categories')
      .orderBy('name', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      menus = snapshot.documents.map((DocumentSnapshot doc) => Menu.fromSnapshot(doc)).toList();
    }

    return Future.delayed(Duration(seconds: 1), () {
      menuController.add(menus);
      return menus;
    });
  }
}