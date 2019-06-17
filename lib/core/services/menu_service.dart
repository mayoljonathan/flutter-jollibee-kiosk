import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';

class MenuService {
  StreamController<List<Menu>> menuController = StreamController<List<Menu>>();

  List<Menu> _menu;
  List<Menu> get menu => _menu;

  List<OptionCategory> _drinks;
  List<OptionCategory> get drinks => _drinks;

  List<OptionCategory> _addOns;
  List<OptionCategory> get addOns => _addOns;

  Future<List<Menu>> getMenu(context) async {
    List<Menu> menus = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('menu')
      .orderBy('sortOrder', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      menus = snapshot.documents.map((DocumentSnapshot doc) => Menu.fromSnapshot(doc)).toList();
    }

    menuController.add(menus);
    _menu = menus;
    return menus;
  }

  Future<List<OptionCategory>> getDrinks(context) async {
    List<OptionCategory> drinks = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('drinks')
      .orderBy('sortOrder', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      drinks = snapshot.documents.map((DocumentSnapshot doc) => OptionCategory.fromSnapshot(doc)).toList();
    }

    _drinks = drinks;
    return drinks;
  }

  Future<List<OptionCategory>> getAddOns(context) async {
    List<OptionCategory> addOns = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('add_ons')
      .orderBy('sortOrder', descending: false)
      .getDocuments();

    if (snapshot.documents.isNotEmpty) {
      addOns = snapshot.documents.map((DocumentSnapshot doc) => OptionCategory.fromSnapshot(doc)).toList();
    }

    _addOns = addOns;
    return addOns;
  }

}