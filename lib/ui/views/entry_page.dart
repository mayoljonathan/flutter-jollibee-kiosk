import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/service_locator.dart';

import 'package:jollibee_kiosk/core/config/theme.dart';
import 'package:jollibee_kiosk/core/config/size_config.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu.dart';
import 'package:jollibee_kiosk/core/viewmodels/entry_model.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

import 'package:jollibee_kiosk/ui/widgets/custom_ui.dart';
import 'package:jollibee_kiosk/ui/widgets/loader/color_loader_3.dart';

class EntryPage extends StatefulWidget {
  @override
  _EntryPageState createState() => _EntryPageState();
}

class _EntryPageState extends State<EntryPage> {

  @override
  void initState() {
    super.initState();
  }

  void _getMenu() => locator<EntryModel>().getMenu(context);

  @override
  Widget build(BuildContext context) {
    print('build entry_page');
    SizeConfig.init(context);
    // this._getMenu();

    // return Scaffold(
    //   body: _buildBackground()
    // );

    return ChangeNotifierProvider<EntryModel>(
      builder: (context) => locator<EntryModel>(),
      child: Consumer<EntryModel>(
        builder: (context, model, child) {
          return Scaffold(
            body: _buildBackground()
          );
        },
      ),
    );
  }

  Widget _buildBackground() {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: kCoreBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.5,
              child: Image.asset('assets/images/jollibee_logo.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeHorizontal * 10),
              child: _buildContentState()
            )
          ],
        )
      )
    );
  }

  Widget _buildContentState() {
    // StreamProvider<Menu>.value(
    //   stream: Menu().stream,
    // );

    // return Provider<Menu>.value(
    //   value: Menu(),
    //   child: Consumer<Menu>(
    //     builder: (ctx, menu, child) {
    //       print('this!!!');
    //       print(menu.state);
    //       Widget widget = Container();
          
    //       if (menu.state == MenuState.IDLE) {
    //         widget = _buildStartState();
    //       } else if (menu.state == MenuState.FETCHING_CATEGORIES) {
    //         widget = _buildFetchingState();
    //       }

    //       return widget;
    //     },
    //   ),
    // );

    // final menu = Menu.of(context, listen: true);
    // print(menu.state);
    // Widget widget = Container();

    // if (menu.state == MenuState.IDLE) {
    //   widget = _buildStartState();
    // } else if (menu.state == MenuState.FETCHING_CATEGORIES) {
    //   widget = _buildFetchingState();
    // }

    return _buildStartState();
  }

  Widget _buildStartState() {
    double size = SizeConfig.blockSizeHorizontal * 30;
    return CustomBouncingContainer(
      onTap: this._getMenu,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text('Touch to Start', 
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.blockSizeHorizontal * 5
              )
            ),
          )
        )
      ),
    );
  }

  Widget _buildFetchingState() {
    return Center(
      child: Column(
        children: <Widget>[
          ColorLoader3(
            centerDotColor: Colors.red,
            radius: SizeConfig.blockSizeHorizontal * 5,
            dotRadius: SizeConfig.blockSizeHorizontal * 2,
            outsideDotColors: [
              kCoreRed,
              kCoreYellow,
              kCoreRed,
              kCoreYellow,
              kCoreRed,
              kCoreYellow,
              kCoreRed,
              kCoreYellow,
            ],
          ),
          Text('Initializing', style: TextStyle(
            fontSize: SizeConfig.blockSizeHorizontal * 5
          ))
        ],
      ),
    );
  }
}