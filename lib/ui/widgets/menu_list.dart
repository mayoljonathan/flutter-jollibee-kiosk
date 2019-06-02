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
    setState(() {});
  }

  bool _shouldArrowUpShow(bool arrowUp) {
    if (_scrollController.hasClients) {
      if (arrowUp) {
        return _scrollController.offset <= 0;
      } else {
        return _scrollController.offset >= _scrollController.position.maxScrollExtent;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
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
            child: IgnorePointer(
              ignoring: _shouldArrowUpShow(true),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: !_shouldArrowUpShow(true) ? 1 : 0,
                child: _buildArrowUp(true),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: IgnorePointer(
              ignoring: _shouldArrowUpShow(false),
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: !_shouldArrowUpShow(false) ? 1 : 0,
                child: _buildArrowUp(false),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildArrowUp(bool arrowUp) {
    IconData icon = arrowUp ? EvaIcons.arrowCircleUp : EvaIcons.arrowCircleDown;
    EdgeInsets padding = arrowUp ? EdgeInsets.only(top: 12.0) : EdgeInsets.only(bottom: 12.0);
    return CustomBouncingContainer(
      onTap: () {
        double itemSize = _scrollController.position.maxScrollExtent / _menus.length;
        double positionOffset = _scrollController.offset - (itemSize * 3); // Defaults to arrowUp
        if (!arrowUp) positionOffset = _scrollController.offset + (itemSize * 3);
        _scrollController.animateTo(positionOffset, duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
      },
      child: Padding(
        padding: padding,
        child: Icon(icon, size: SizeConfig.blockSizeHorizontal * 5),
      ),
    );
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
                  fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                  fontWeight: FontWeight.w500
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