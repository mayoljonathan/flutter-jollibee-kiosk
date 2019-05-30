// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:jollibee_kiosk/core/models/menu.dart';

// class Menu {
//   /// Wraps [Provider.of] for this [Model].
//   static Menu of(BuildContext context, {bool listen = true}) => Provider.of<Menu>(context, listen: listen);

//   final StreamController<int> _streamController = StreamController();
//   Stream<int> stream;
//   Menu() { stream = _streamController.stream.asBroadcastStream(); }

//   List<Category> categories = [];
//   MenuState state = MenuState.IDLE;

//   // final StreamController<MenuState> _streamState = StreamController();
//   // Stream<MenuState> streamMenuState;


//   void dispose() {
//     _streamController.close();
//   }
// }

// enum MenuState {
//   IDLE,
//   FETCHING_CATEGORIES
// }