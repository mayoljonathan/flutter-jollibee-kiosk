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
            itemBuilder: (context, i) => ItemTile(item: items[i]),
          );
        },
      ),
    );
  }

  Widget _buildEmptyItemsState() {
    return Center(child: Text('No items'));
  }
}

class ItemTile extends StatelessWidget {
  ItemTile({@required this.item});

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return CustomBouncingContainer(
      upperBound: 0.25,
      onTap: () {
        Provider.of<ItemDetailModel>(context, listen: false).selectedMenuItem = item;
        Navigator.pushNamed(context, '/item-detail', arguments: {
          'heroTag': item.id,
          'item': item,
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
                    tag: item.id,
                    placeholderBuilder: (context, size, widget) => widget,
                    child: FadeInImage.memoryNetwork(
                      key: ValueKey(item.id),
                      placeholder: kTransparentImage,
                      image: item.image,
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
                      child: Text(item.priceToString(), style: TextStyle(
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
              item.name,
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
    );
  }
}
