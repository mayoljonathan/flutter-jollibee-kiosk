import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/models/cart.dart';
import 'package:jollibee_kiosk/core/viewmodels/item_detail_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:jollibee_kiosk/ui/widgets/quantity_picker.dart';

class ItemDetailView extends StatefulWidget {
  ItemDetailView({
    @required this.heroTag,
    @required this.item,
    this.optionSelections,
    this.quantity,
    this.isEditing = false,
    this.menuItemCartId
  });

  final String heroTag;
  final MenuItem item;
  final Map<ItemOption, List<OptionItemCart>> optionSelections;
  final int quantity;
  final bool isEditing;
  final String menuItemCartId;

  @override
  _ItemDetailViewState createState() => _ItemDetailViewState();
}

class _ItemDetailViewState extends State<ItemDetailView> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Provider<ItemDetailModel>.value(
      value: locator<ItemDetailModel>(),
      child: Consumer<ItemDetailModel>(
        builder: (context, model, child) {
          print('BUILD!');
          model.setInitialValues(
            optionSelections: widget.optionSelections,
            quantity: widget.quantity,
            selectedMenuItem: widget.item,
            isEditing: widget.isEditing
          );

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
                    ListenableProvider.value(
                      listenable: locator<ItemDetailModel>(),
                      child: ItemOptions(
                        hasAddOns: widget.item.hasAddOns ?? false,
                        hasDrinks: widget.item.hasDrinks ?? false,
                        maxDrinkSelection: widget.item.maxDrinkSelection ?? 1,
                        maxAddOnSelection: widget.item.maxAddOnSelection ?? 1,
                      ),
                    ),
                    Divider(height: 48.0),
                    _buildFooter(context, null)
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
      tag: widget.heroTag,
      child: FadeInImage.memoryNetwork(
        key: ValueKey(widget.item.id),
        placeholder: kTransparentImage,
        image: widget.item.image,
        fit: BoxFit.contain,
        width: (SizeConfig.blockSizeHorizontal * 30),
      ),
    );
  }

  Widget _buildItemName() {
    return Text(widget.item.name, style: TextStyle(
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
                ListenableProvider(
                  builder: (BuildContext context) => locator<ItemDetailModel>(),
                  child: Consumer<ItemDetailModel>(
                    builder: (context, model, child) => QuantityPicker(
                      initialValue: model.quantity,
                      onChanged: (int qty) => model.quantity = qty
                    ),
                  ),
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
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: kRed,
          width: 2
        ),
        borderRadius: BorderRadius.circular(9.0)
      ),
      child: AnimatedSize(
        duration: Duration(milliseconds: 400),
        vsync: this,
        curve: Curves.fastOutSlowIn,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text('Meal Total', style: TextStyle(
              fontSize: kBodyTextSize,
              fontWeight: FontWeight.w500
            )),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ListenableProvider(
                  builder: (BuildContext context) => locator<ItemDetailModel>(),
                  child: Consumer<ItemDetailModel>(
                    builder: (context, model, child) => Text(model.getMealTotalToString(), style: TextStyle(
                      fontSize: kActionButtonTextSize,
                      fontWeight: FontWeight.bold
                    ))
                  )
                ),
              ),
            ),
          ],
        ),
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
              text: !widget.isEditing ? 'Add to My Order' : 'Update My Order', 
              color: kGreen,
              onTap: () {
                if (!widget.isEditing) {
                  return model.onAddMenuItemToOrder(context);
                } 
                model.onUpdateMenuItemFromOrder(context, id: widget.heroTag);
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
            fontSize: kActionButtonTextSize,
            fontWeight: FontWeight.bold
          )
        )
      )
    );
  }
}
