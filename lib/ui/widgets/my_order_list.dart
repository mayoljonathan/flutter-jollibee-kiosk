import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/cart.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';

class MyOrderList extends StatelessWidget {
  MyOrderList({
    Key key,
    @required this.animatedListKeyIndex
  }) : super(key:key);

  final int animatedListKeyIndex;

  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      builder: (BuildContext context) => locator<MyCartModel>(),
      child: Consumer<MyCartModel>(
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 18.0),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 200),
                    opacity: model.items.length == 0 ? 1 : 0,
                    child: _buildEmptyCartState()
                  )
                ),
                AnimatedList(
                  key: model.animatedListKeys[animatedListKeyIndex],
                  controller: model.scrollController,
                  physics: BouncingScrollPhysics(),
                  initialItemCount: model.items.length,
                  itemBuilder: (BuildContext context, int i, Animation animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: MyOrderItemTile(
                        key: ValueKey<String>(model.items[i].menuItem.id),
                        item: model.items[i],
                        index: i
                      )
                    );
                  }
                ),
              ],
            ),
          );
        }
      )
    );
  }

  Widget _buildEmptyCartState() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text("Select a menu and add a meal to see it here.", style: TextStyle(
        fontSize: kBodyTextSize
      ))
    );
  }
}

class MyOrderItemTile extends StatefulWidget {
  MyOrderItemTile({
    Key key,
    @required this.item,
    @required this.index
  }) : super (key: key);

  final MenuItemCart item;
  final int index;

  @override
  _MyOrderItemTileState createState() => _MyOrderItemTileState();
}

class _MyOrderItemTileState extends State<MyOrderItemTile> with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedSize(
        vsync: this,
        duration: Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () => Provider.of<MyCartModel>(context).onEditMenuItem(context, widget.item),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildQuantity(context),
                      _buildImage(),
                      Expanded(child: _buildName()),
                      _buildPrice(context),
                    ],
                  ),
                  if (widget.item.drinks.length > 0 || widget.item.addOns.length > 0) Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 52, right: 16),
                        child: Text('Includes:', style: TextStyle(
                          fontSize: kCaptionTextSize
                        ))
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (widget.item.drinks.length > 0) ..._buildOptionItemList(widget.item.drinks),
                          if (widget.item.addOns.length > 0) ..._buildOptionItemList(widget.item.addOns),
                        ],
                      )
                    ],
                  ),
                  _buildActionButtons(context),
                ],
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildActionButtonItem(context, 
            text: 'Edit', 
            color: kGreen,
            onTap: () => Provider.of<MyCartModel>(context).onEditMenuItem(context, widget.item)
          ),
          SizedBox(width: 6.0),
          _buildActionButtonItem(context, 
            text: 'Remove',
            onTap: () => Provider.of<MyCartModel>(context).removeMenuItem(widget.item, index: widget.index, child: build(context))
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return CustomBouncingContainer(
      onTap: onTap == null ? () {} : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: color,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: Text(text, 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: SizeConfig.blockSizeHorizontal * 2.3,
            fontWeight: FontWeight.w500
          )
        )
      )
    );
  }

  Widget _buildQuantity(context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 36.0
      ),
      padding: const EdgeInsets.all(6.0),
      margin: const EdgeInsets.only(right: 12.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6.0)
      ),
      child: Text('x${widget.item.quantity.toString()}', style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: kOverlineTextSize
      ))
    );
  }

  Widget _buildImage() {
    double size = SizeConfig.blockSizeHorizontal * 10;
    return Hero(
      tag: widget.item.id,
      placeholderBuilder: (context, size, widget) => widget,
      child: FadeInImage.memoryNetwork(
        width: size,
        height: size,
        placeholder: kTransparentImage,
        image: widget.item.menuItem.image,
        fit: BoxFit.contain
      )
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(widget.item.menuItem.name, style: TextStyle(
        fontSize: kCaptionTextSize,
        fontWeight: FontWeight.bold
      )),
    );
  }

  List<Widget> _buildOptionItemList(List<OptionItemCart> oicList) {
    return oicList.map((OptionItemCart oic) => Text('${oic.name} x${oic.quantity * widget.item.quantity}', style: TextStyle(
      fontSize: kCaptionTextSize
    ))).toList();
  }

  Widget _buildPrice(context) {
    String priceAsString = Provider.of<MyCartModel>(context).getTotalPricePerMenuItemCartToString(widget.item);
    return Text(priceAsString, style: TextStyle(
      fontSize: kCaptionTextSize,
      fontWeight: FontWeight.w500
    ));
  }
}