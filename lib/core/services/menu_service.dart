import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/drink.dart';
import 'package:jollibee_kiosk/core/models/add_on.dart';

class MenuService {
  StreamController<List<Menu>> menuController = StreamController<List<Menu>>();
  StreamController<List<Drink>> drinkController = StreamController<List<Drink>>();
  StreamController<List<AddOn>> addOnController = StreamController<List<AddOn>>();

  Future<List<Menu>> getMenu(context) async {
    List<Menu> menus = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('menu')
      .orderBy('sortOrder', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      menus = snapshot.documents.map((DocumentSnapshot doc) => Menu.fromSnapshot(doc)).toList();
    }

    return Future.delayed(Duration(seconds: 1), () {
      menuController.add(menus);
      return menus;
    });
  }

  Future<List<Drink>> getDrinks(context) async {
    List<Drink> drinks = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('drinks')
      .orderBy('sortOrder', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      drinks = snapshot.documents.map((DocumentSnapshot doc) => Drink.fromSnapshot(doc)).toList();
    }

    return Future.delayed(Duration(seconds: 1), () {
      drinkController.add(drinks);
      return drinks;
    });
  }

  Future<List<AddOn>> getAddOns(context) async {
    List<AddOn> addOns = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('add_ons')
      .orderBy('sortOrder', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      addOns = snapshot.documents.map((DocumentSnapshot doc) => AddOn.fromSnapshot(doc)).toList();
    }

    return Future.delayed(Duration(seconds: 1), () {
      addOnController.add(addOns);
      return addOns;
    });
  }

}