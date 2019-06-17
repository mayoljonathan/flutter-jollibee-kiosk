import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';

class OrderService {
  
  // Future<List<Menu>> getMenu(context) async {
  //   List<Menu> menus = [];

  //   QuerySnapshot snapshot = await Firestore.instance.collection('menu')
  //     .orderBy('sortOrder', descending: false)
  //     .getDocuments();

  //   if (snapshot.documents.isNotEmpty) {
  //     menus = snapshot.documents.map((DocumentSnapshot doc) => Menu.fromSnapshot(doc)).toList();
  //   }

  //   menuController.add(menus);
  //   _menu = menus;
  //   return menus;
  // }

}