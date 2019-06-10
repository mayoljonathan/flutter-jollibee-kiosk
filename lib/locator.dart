import 'package:get_it/get_it.dart';

import 'package:jollibee_kiosk/core/viewmodels/entry_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/home_model.dart';

import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/item_detail_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton<MenuService>(() => MenuService());

  locator.registerLazySingleton<EntryModel>(() => EntryModel());
  locator.registerFactory<MenuModel>(() => MenuModel());
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerLazySingleton<ItemDetailModel>(() => ItemDetailModel());
  locator.registerLazySingleton<MyCartModel>(() => MyCartModel());
}