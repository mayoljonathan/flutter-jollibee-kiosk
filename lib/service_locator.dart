import 'package:get_it/get_it.dart';

import 'package:jollibee_kiosk/core/viewmodels/entry_model.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(MenuService());
  locator.registerLazySingleton(() => EntryModel());
}