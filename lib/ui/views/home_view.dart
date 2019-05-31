import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/ui/widgets/item_grid.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';

import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/home_model.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';

import 'package:jollibee_kiosk/ui/views/base_view.dart';

import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';

import 'package:jollibee_kiosk/ui/widgets/my_cart.dart';
import 'package:jollibee_kiosk/ui/widgets/menu_list.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  MenuModel _model;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<MenuModel>(
      onModelReady: (model) {
        _model = model;
        _model.setInitialSelectedMenu(context);
      },
      builder: (context, model, child) {
        print('home view build');
        return SafeArea(
          child: Scaffold(
            backgroundColor: kScaffoldBackgroundColor,
            body: _buildBody(),
            bottomNavigationBar: MyCart(),
          ),
        );
      }
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHeader(),
        Expanded(
          child: Row(
            children: <Widget>[
              MenuList(),
              Expanded(child: ItemGrid())     
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
            width: SizeConfig.blockSizeHorizontal * 20,
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage('assets/images/jollibee_icon.png'),
            )
          ),
          Text(_model?.selectedMenu?.name ?? '' , style: TextStyle(
            fontSize: kTitleTextSize,
            fontWeight: FontWeight.bold
          ))
        ],
      )
    );
  }
  
}