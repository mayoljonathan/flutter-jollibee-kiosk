import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:jollibee_kiosk/ui/widgets/quantity_picker.dart';

class ItemDetailView extends StatelessWidget {
  ItemDetailView({
    @required this.item
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    return FullscreenDialog(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildHeader(),
              SizedBox(height: 12.0),
              Row(
                children: <Widget>[
                  _buildItemImage(),
                  SizedBox(width: 24.0),
                  Expanded(child: _buildItemName()),
                ],
              ),
              SizedBox(height: 48.0),
              ItemOptions(
                hasAddOns: item.hasAddOns ?? false,
                hasDrinks: item.hasDrinks ?? false,
                maxDrinkSelection: item.maxDrinkSelection ?? 1,
                maxAddOnSelection: item.maxAddOnSelection ?? 1,
              ),
              SizedBox(height: 12.0),
              _buildFooter(context)
            ],
          )
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text('Make your choice', style: TextStyle(
      fontSize: kTitleTextSize,
      fontWeight: FontWeight.bold
    ));
  }

  Widget _buildItemImage() {
    return Hero(
      tag: item.id,
      child: FadeInImage.memoryNetwork(
        key: ValueKey(item.id),
        placeholder: kTransparentImage,
        image: item.image,
        fit: BoxFit.contain,
        width: (SizeConfig.blockSizeHorizontal * 30),
      ),
    );
  }

  Widget _buildItemName() {
    return Hero(
      tag: 'item-name-${item.id}',
      child: Text(item.name, style: TextStyle(
        fontSize: kSubheadTextSize,
      )),
    );
  }

  Widget _buildFooter(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Quantity', style: TextStyle(
                  fontSize: kBodyTextSize
                )),
                SizedBox(height: 12.0),
                QuantityPicker(
                  onChanged: (int qty) {
                    // TODO
                    print(qty);
                  },
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: _buildMealTotal()
            ),
          ],
        ),
        SizedBox(height: 24.0),
        _buildActionButtons(context)
      ],
    );
  }

  Widget _buildMealTotal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('Meal Total', style: TextStyle(
          fontSize: kBodyTextSize,
        )),
        SizedBox(height: 12.0),
        SizedBox(
          height: (SizeConfig.blockSizeHorizontal * 5) + 12,
          child: Align(
            alignment: Alignment.center,
            child: Text(item.priceToString(), style: TextStyle(
              fontSize: SizeConfig.blockSizeHorizontal * 3,
              fontWeight: FontWeight.bold
            )),
          ),
        ),
      ],
    );
    // return Text(item.priceToString(), style: TextStyle(
    //   fontSize: SizeConfig.blockSizeHorizontal * 3
    // ));
    // return Column(
    //   mainAxisSize: MainAxisSize.max,
    //   children: <Widget>[
    //     Text('Meal Total', style: TextStyle(
    //       fontSize: kBodyTextSize
    //     )),
    //     SizedBox(height: 12.0),
    //     Text(item.priceToString(), style: TextStyle(
    //       fontSize: SizeConfig.blockSizeHorizontal * 3
    //     )),
    //   ],
    // );
  }

  Widget _buildActionButtons(context) {
    return Row(
      children: <Widget>[
        Expanded(child: _buildActionButtonItem(context, text: 'Cancel')),
        SizedBox(width: 18.0),
        Expanded(child: _buildActionButtonItem(context, text: 'Add to My Order', color: kGreen)),
      ],
    );
  }

  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return CustomBouncingContainer(
      onTap: onTap == null ? () => Navigator.pop(context) : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: color,
        ),
        padding: const EdgeInsets.all(18.0),
        child: Text(text, 
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: kActionButtonTextSize
          )
        )
      )
    );
  }
}