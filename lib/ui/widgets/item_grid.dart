import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/viewmodels/item_detail_model.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';

import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';

class ItemGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MenuModel>.value(value: MenuModel()),
        Provider<ItemDetailModel>.value(value: ItemDetailModel()),
      ],
      child: Builder(
        builder: (_) {
          List<MenuItem> items = Provider.of<MenuModel>(context).selectedMenu.items;
          if (items == null || items.length <= 0)
            return _buildEmptyItemsState();

          return GridView.builder(
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: SizeConfig.blockSizeHorizontal * 30,
              mainAxisSpacing: 18.0,
            ),
            padding: const EdgeInsets.all(18.0),
            itemCount: items.length,
            itemBuilder: (context, i) => ItemTile(
              key: ValueKey(items[i].id),
              item: items[i]
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyItemsState() {
    return Center(child: Text('No items', style: TextStyle(
      fontSize: kActionButtonTextSize
    )));
  }
}

class ItemTile extends StatefulWidget {
  ItemTile({Key key, @required this.item}) : super(key:key);

  final MenuItem item;

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> with TickerProviderStateMixin {

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400), 
      vsync: this,
      lowerBound: 0.1,
    );            

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve:  Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn
    ));

    _animationController.addListener(() => setState(() {}));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _animation.value,
      child: AnimatedOpacity(
        opacity: _animation.value,
        duration: Duration(milliseconds: 200),
        child: CustomBouncingContainer(
          upperBound: 0.25,
          onTap: () {
            Provider.of<ItemDetailModel>(context, listen: false).selectedMenuItem = widget.item;
            Navigator.pushNamed(context, '/item-detail', arguments: {
              'heroTag': widget.item.id,
              'item': widget.item,
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: SizeConfig.blockSizeHorizontal * 15,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Hero(
                        tag: widget.item.id,
                        placeholderBuilder: (context, size, widget) => widget,
                        child: FadeInImage.memoryNetwork(
                          key: ValueKey(widget.item.id),
                          placeholder: kTransparentImage,
                          image: widget.item.image,
                          fit: BoxFit.contain
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomLeft: Radius.circular(3.0),
                          bottomRight: Radius.circular(3.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(6.0),
                          color: kRed,
                          child: Text(widget.item.priceToString(), style: TextStyle(
                            color: Colors.white,
                            fontSize: kCaptionTextSize,
                            fontWeight: FontWeight.bold
                          ))
                        ),
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0),
              Expanded(
                child: Text(
                  widget.item.name,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeHorizontal * 2.5,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );

    // return CustomBouncingContainer(
    //   upperBound: 0.25,
    //   onTap: () {
    //     Provider.of<ItemDetailModel>(context, listen: false).selectedMenuItem = widget.item;
    //     Navigator.pushNamed(context, '/item-detail', arguments: {
    //       'heroTag': widget.item.id,
    //       'item': widget.item,
    //     });
    //   },
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Container(
    //         height: SizeConfig.blockSizeHorizontal * 15,
    //         width: double.infinity,
    //         child: Stack(
    //           children: <Widget>[
    //             Positioned.fill(
    //               child: Hero(
    //                 tag: widget.item.id,
    //                 placeholderBuilder: (context, size, widget) => widget,
    //                 child: FadeInImage.memoryNetwork(
    //                   key: ValueKey(widget.item.id),
    //                   placeholder: kTransparentImage,
    //                   image: widget.item.image,
    //                   fit: BoxFit.contain
    //                 ),
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.bottomRight,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.only(
    //                   topLeft: Radius.circular(12.0),
    //                   topRight: Radius.circular(12.0),
    //                   bottomLeft: Radius.circular(3.0),
    //                   bottomRight: Radius.circular(3.0),
    //                 ),
    //                 child: Container(
    //                   padding: const EdgeInsets.all(6.0),
    //                   color: kRed,
    //                   child: Text(widget.item.priceToString(), style: TextStyle(
    //                     color: Colors.white,
    //                     fontSize: kCaptionTextSize,
    //                     fontWeight: FontWeight.bold
    //                   ))
    //                 ),
    //               )
    //             ),
    //           ],
    //         ),
    //       ),
    //       SizedBox(height: 6.0),
    //       Expanded(
    //         child: Text(
    //           widget.item.name,
    //           textAlign: TextAlign.center,
    //           maxLines: 3,
    //           overflow: TextOverflow.ellipsis,
    //           style: TextStyle(
    //             fontSize: SizeConfig.blockSizeHorizontal * 2.5,
    //             fontWeight: FontWeight.w500
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
