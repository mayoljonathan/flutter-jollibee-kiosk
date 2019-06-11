import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/models/cart.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';

import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 32,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(40.0, 20.0),
            topRight: Radius.elliptical(40.0, 20.0),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -5.0),
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1, 
              blurRadius: 12.0,
            )
          ],
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListenableProvider(
            builder: (BuildContext context) => locator<MyCartModel>(),
            child: Consumer<MyCartModel>(
              builder: (context, model, child) {
                String text = 'My Order';
                if (model.items.length > 0) {
                  if (model.items.length == 1) text += ' (1 item)';
                  else text += ' (${model.getTotalItemsIncludeItemQty()} items)';
                } 

                return Text(text, style: TextStyle(
                  fontSize: kSubheadTextSize,
                  fontWeight: FontWeight.w500
                ));
              }
            )
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: _buildCartList()
                ),
                Expanded(
                  flex: 2,
                  child: _buildRightLayout()
                )    
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _buildCartList() {
    return ListenableProvider(
      builder: (BuildContext context) => locator<MyCartModel>(),
      child: Consumer<MyCartModel>(
        builder: (context, model, child) {
          if (model.items.length == 0) return _buildEmptyCartState();

          return Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 18.0),
            child: ListView.separated(
              controller: model.scrollController,
              separatorBuilder: (_, __) => Divider(),
              physics: BouncingScrollPhysics(),
              itemCount: model.items.length,
              itemBuilder: (BuildContext context, int i) => MyCartItemTile(
                item: model.items[i],
                key: ValueKey(model.items[i].menuItem.id),
              )
            ),
          );
        }
      )
    );
  }

  Widget _buildRightLayout() {
    return ListenableProvider(
      builder: (BuildContext context) => locator<MyCartModel>(),
      child: Consumer<MyCartModel>(
        builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kRed,
                      width: 2
                    ),
                    borderRadius: BorderRadius.circular(9.0)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('Order Total', style: TextStyle(
                        fontSize: kActionButtonTextSize,
                      )),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(Provider.of<MyCartModel>(context).getOrderTotalToString(), style: TextStyle(
                            fontSize: kSubheadTextSize,
                            fontWeight: FontWeight.bold
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.0),
              CustomBouncingContainer(
                onTap: this._onReviewOrderTap,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Provider.of<MyCartModel>(context).items.length == 0 ? kGrey : kGreen,
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Text('Review Order', 
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kActionButtonTextSize
                    )
                  )
                )
              )
            ],
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

  void _onReviewOrderTap() {
    // if (model.items.length == 0) return;
    // TODO
  }
}

class MyCartItemTile extends StatelessWidget {
  MyCartItemTile({
    Key key,
    @required this.item
  }) : super (key: key);

  final MenuItemCart item;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Provider.of<MyCartModel>(context).onEditMenuItem(context, item),
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
            if (item.drinks.length > 0 || item.addOns.length > 0) Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 44, right: 16),
                  child: Text('Includes:', style: TextStyle(
                    fontSize: kCaptionTextSize
                  ))
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (item.drinks.length > 0) ..._buildOptionItemList(item.drinks),
                    if (item.addOns.length > 0) ..._buildOptionItemList(item.addOns),
                  ],
                )
              ],
            ),
            _buildActionButtons(context)
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
            onTap: () => Provider.of<MyCartModel>(context).onEditMenuItem(context, item)
          ),
          SizedBox(width: 6.0),
          _buildActionButtonItem(context, 
            text: 'Remove',
            onTap: () => Provider.of<MyCartModel>(context).removeMenuItem(item)
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
            fontSize: SizeConfig.blockSizeHorizontal * 2.3
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
      child: Text('x${item.quantity.toString()}', style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: kOverlineTextSize
      ))
    );
  }

  Widget _buildImage() {
    double size = SizeConfig.blockSizeHorizontal * 10;
    return Hero(
      tag: item.id,
      placeholderBuilder: (context, widget) => widget,
      child: FadeInImage.memoryNetwork(
        width: size,
        height: size,
        placeholder: kTransparentImage,
        image: item.menuItem.image,
        fit: BoxFit.contain
      )
    );
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Text(item.menuItem.name, style: TextStyle(
        fontSize: kCaptionTextSize,
        fontWeight: FontWeight.bold
      )),
    );
  }

  List<Widget> _buildOptionItemList(List<OptionItemCart> oicList) {
    return oicList.map((OptionItemCart oic) => Text('${oic.name} x${oic.quantity * item.quantity}', style: TextStyle(
      fontSize: kCaptionTextSize
    ))).toList();
  }

  Widget _buildPrice(context) {
    String priceAsString = Provider.of<MyCartModel>(context).getTotalPricePerMenuItemCartToString(item);
    return Text(priceAsString, style: TextStyle(
      fontSize: kCaptionTextSize,
    ));
  }
}