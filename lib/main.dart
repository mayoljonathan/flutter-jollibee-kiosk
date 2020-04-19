import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jollibee_kiosk/ui/views/splash_view.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

import 'package:jollibee_kiosk/ui/router.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Menu>>(
      initialData: [],
      builder: (context) => locator<MenuService>().menuController,
      child: MaterialApp(
        title: 'Jollibee Kiosk',
        debugShowCheckedModeBanner: false,
        theme: kMaterialThemeData,
        home: SplashView(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
