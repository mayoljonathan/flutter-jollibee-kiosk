import 'package:get_it/get_it.dart';


import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/services/order_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/item_detail_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/entry_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/payment_model.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton<MenuService>(() => MenuService());
  locator.registerLazySingleton<OrderService>(() => OrderService());

  locator.registerFactory<EntryModel>(() => EntryModel());
  locator.registerFactory<MenuModel>(() => MenuModel());
  locator.registerLazySingleton<ItemDetailModel>(() => ItemDetailModel());
  locator.registerLazySingleton<MyCartModel>(() => MyCartModel());

  locator.registerFactory<PaymentModel>(() => PaymentModel());
}