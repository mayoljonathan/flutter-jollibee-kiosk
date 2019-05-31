import 'package:flutter/material.dart';
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

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Provider<Menu>(
    //   builder: (_) => Menu(),
    //   dispose: (_, value) => value.dispose(),
    //   child: MaterialApp(
    //     title: 'Jollibee Kiosk',
    //     debugShowCheckedModeBanner: false,
    //     theme: kMaterialThemeData,
    //     home: EntryPage(),
    //   )
    // );

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


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Baby Names',
//      home: MyHomePage(),
//    );
//  }
// }

// class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() {
//    return _MyHomePageState();
//  }
// }

// class _MyHomePageState extends State<MyHomePage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Baby Name Votes')),
//      body: _buildBody(context),
//    );
//  }

//  Widget _buildBody(BuildContext context) {
//    // TODO: get actual snapshot from Cloud Firestore
//   return StreamBuilder<QuerySnapshot>(
//     stream: Firestore.instance.collection('baby').snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) return LinearProgressIndicator();

//       return _buildList(context, snapshot.data.documents);
//     },
//   );
//  }

//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.only(top: 20.0),
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//    );
//  }

//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Record.fromSnapshot(data);

//    return Padding(
//      key: ValueKey(record.name),
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.grey),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        child: ListTile(
//          title: Text(record.name),
//          trailing: Text(record.votes.toString()),
//          onTap: () => print(record),
//        ),
//      ),
//    );
//  }
// }

// class Record {
//  final String name;
//  final int votes;
//  final DocumentReference reference;

//  Record.fromMap(Map<String, dynamic> map, {this.reference})
//      : assert(map['name'] != null),
//        assert(map['votes'] != null),
//        name = map['name'],
//        votes = map['votes'];

//  Record.fromSnapshot(DocumentSnapshot snapshot)
//      : this.fromMap(snapshot.data, reference: snapshot.reference);

//  @override
//  String toString() => "Record<$name:$votes>";
// }