import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

import 'package:jollibee_kiosk/ui/router.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/views/entry_view.dart';

// Future<void> main() async {
//   final FirebaseApp firebaseApp = await FirebaseApp.configure(
//     name: 'Jollibee POC',
//     options: const FirebaseOptions(
//       googleAppID: '1:1086863951483:android:c05bfc0ee926e97e',
//       apiKey: 'AIzaSyAVhTBchUJP7bRgoIxLOtMJgweCW7aKJm4',
//       databaseURL: 'https://jollibee-poc.firebaseio.com',
//     ),
//   );

//   runApp(MyApp(firebaseApp: firebaseApp));
// }

void main() async {
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
        home: EntryView(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
