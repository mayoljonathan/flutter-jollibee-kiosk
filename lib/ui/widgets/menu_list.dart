import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';

class MenuList extends StatefulWidget {
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  List<Menu> _menus;

  ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _menus = Provider.of<List<Menu>>(context, listen: false);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // print(_scrollController.offset);
    setState(() {});
  }

  bool _hasReachedTop() {
    if (_scrollController.hasClients) {
      return _scrollController.offset <= 0;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    print(_hasReachedTop());
    return Stack(
      children: <Widget>[
        Container(
          width: SizeConfig.blockSizeHorizontal * 20,
          color: Colors.white,
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: _menus.length,
            itemBuilder: (_, int i) => MenuTile(menu: _menus[i]),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: !_hasReachedTop() ? _buildArrow(true) : Container(height: 0, width: 0),
          ),
        ),
        // AnimatedContainer(
        //   duration: Duration(milliseconds: 200),
        //   height: _hasReachedTop() ? 0 : 10,
        //   width: SizeConfig.blockSizeHorizontal * 20,
        //   child: _buildArrow()
        // ),
      ],
    );
    // return Container(
    //   width: SizeConfig.blockSizeHorizontal * 20,
    //   color: Colors.white,
    //   // decoration: BoxDecoration(
    //   //   boxShadow: <BoxShadow>[
    //   //     BoxShadow(
    //   //       color: Colors.grey,
    //   //       spreadRadius: 1, 
    //   //       blurRadius: 12.0,
    //   //       offset: Offset(-(SizeConfig.blockSizeHorizontal * 20)/20, 0)
    //   //     )
    //   //   ]
    //   // ),
    //   child: ListView.builder(
    //     controller: _scrollController,
    //     padding: const EdgeInsets.symmetric(vertical: 6.0),
    //     physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
    //     itemCount: _menus.length,
    //     itemBuilder: (_, int i) => MenuTile(menu: _menus[i]),
    //   ),
    // );
  }

  Widget _buildArrow(bool arrowUp) {
    IconData icon = arrowUp ? EvaIcons.arrowCircleUp : EvaIcons.arrowDown;
    return Icon(icon, size: SizeConfig.blockSizeHorizontal * 4);
  }
}

class MenuTile extends StatelessWidget {
  MenuTile({@required this.menu});

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => MenuModel(),
      dispose: (_, val) => val.dispose(),
      child: CustomBouncingContainer(
        upperBound: 0.25,
        onTap: () {
          Provider.of<MenuModel>(context).selectedMenu = menu;
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: menu.image,
                height: (SizeConfig.blockSizeHorizontal * 12) - 24,
              ),
              SizedBox(height: 6.0),
              Text(menu.name, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeHorizontal * 2.5
                )
              ),
              // Text(Provider.of<MenuModel>(context).isSelectedMenu(menu.documentID).toString())
            ],
          )
        ),
      )
    );
  }
}