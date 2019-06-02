import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';

class MenuService {
  StreamController<List<Menu>> menuController = StreamController<List<Menu>>();

  Future<List<Menu>> getMenu(context) async {
    List<Menu> menus = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('menu')
      .orderBy('sortOrder', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      // menus = snapshot.documents.map((DocumentSnapshot doc) => Menu.fromSnapshot(doc)).toList();
      menus = snapshot.documents.map((DocumentSnapshot doc) => Menu.fromSnapshot(doc)).toList();
      print(menus);
    }

    // var snapshot = test();

    // menus = snapshot.map((data) {
    //   print(data);
    //   return Menu.fromJson(data);
    // }).toList();

    // print(menus);

    return Future.delayed(Duration(seconds: 1), () {
      menuController.add(menus);
      return menus;
    });
  }

  List<Map<String,dynamic>> test() {
    List<Map<String, dynamic>> json = [{
      'name': 'Chicken',
      'image': 'https://www.jollibee.com.ph/wp-content/uploads/JB_PRODUCT-BANNER-AD_CHICKENJOY-WITH-BURGER-STEAK-AND-HALF-SPAGHETTI_FA.png',
      'items': [
        {
          'id': 'qwe',
          'name': '1-pc Chickenjoy (Solo)',
          'image': 'http://www.vozzog.com/images/resto/l_fd929_1pcchickenwithriceres.jpg',
          'price': 82
        }
      ]
    }];

    return json;
  }
}