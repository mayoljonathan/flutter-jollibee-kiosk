import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/viewmodels/item_detail_model.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:jollibee_kiosk/ui/widgets/quantity_picker.dart';

class ItemDetailView extends StatelessWidget {
  ItemDetailView({@required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemDetailModel>(
      builder: (BuildContext context) => ItemDetailModel(),
      child: Consumer<ItemDetailModel>(
        builder: (context, model, child) {
          model.selectedMenuItem = item;

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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: <Widget>[
                          _buildItemImage(),
                          SizedBox(width: 24.0),
                          Expanded(child: _buildItemName()),
                        ],
                      ),
                    ),
                    ItemOptions(
                      hasAddOns: item.hasAddOns ?? false,
                      hasDrinks: item.hasDrinks ?? false,
                      maxDrinkSelection: item.maxDrinkSelection ?? 1,
                      maxAddOnSelection: item.maxAddOnSelection ?? 1,
                    ),
                    Divider(height: 48.0),
                    _buildFooter(context, model)
                  ],
                )
              ),
            ),
          );
        },
      )
    );
  }

  Widget _buildHeader() {
    return Text('Choose your options', style: TextStyle(
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
    return Text(item.name, style: TextStyle(
      fontSize: kSubheadTextSize,
    ));
  }

  Widget _buildFooter(context, ItemDetailModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Meal Quantity', style: TextStyle(
                  fontSize: kBodyTextSize
                )),
                SizedBox(height: 12.0),
                QuantityPicker(
                  onChanged: (int qty) => model.quantity = qty
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: _buildMealTotal(model)
            ),
          ],
        ),
        SizedBox(height: 24.0),
        _buildActionButtons(context)
      ],
    );
  }

  Widget _buildMealTotal(ItemDetailModel model) {
    return Container(
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
          Text('Meal Total', style: TextStyle(
            fontSize: kBodyTextSize,
          )),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(model.getMealTotalToString(), style: TextStyle(
                fontSize: kActionButtonTextSize,
                fontWeight: FontWeight.bold
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(context) {
    return Row(
      children: <Widget>[
        Expanded(child: _buildActionButtonItem(context, text: 'Cancel')),
        SizedBox(width: 18.0),
        Expanded(child: 
          Consumer<ItemDetailModel>(
            builder: (context, model, child) => _buildActionButtonItem(context, 
              text: 'Add to My Order', 
              color: kGreen,
              onTap: () {
                model.onAddMenuItemToOrder(context, item: item);
              }
            )
          )
        ),
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