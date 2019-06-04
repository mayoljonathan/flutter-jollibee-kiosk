import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';

enum ItemOption { Drink, AddOn }

class ItemOptions extends StatefulWidget {
  ItemOptions({
    this.hasDrinks = false,
    this.hasAddOns = false,
    this.maxSelectedDrinks = 1,
    this.maxSelectedAddOns = 1
  });

  final bool hasDrinks;
  final bool hasAddOns;
  final int maxSelectedDrinks;
  final int maxSelectedAddOns;

  @override
  _ItemOptionsState createState() => _ItemOptionsState();
}

class _ItemOptionsState extends State<ItemOptions> {

  MenuModel _model;
  List<ItemOption> itemOptions = [];

  @override
  void initState() {
    super.initState();
    if (widget.hasDrinks) itemOptions.add(ItemOption.Drink);
    if (widget.hasAddOns) itemOptions.add(ItemOption.AddOn);
  }

  String itemOptionToString(ItemOption itemOption) {
    String optionName = '';
    switch (itemOption) {
      case ItemOption.Drink:
        optionName = 'Drinks';
        break;
      case ItemOption.AddOn:
        optionName = 'Add-On';
        break;
    }
    return optionName;
  }

  @override
  Widget build(BuildContext context) {
    if (itemOptions.length == 0 ) return Container();

    return BaseView<MenuModel>(
      onModelReady: (MenuModel model) => _model = model,
      builder: (context, model, child) => Column(
        children: itemOptions.asMap().map((i, ItemOption option) => MapEntry(i, _buildOption(i, option))).values.toList()
      )
    );
  }

  Widget _buildOption(int i, ItemOption itemOption) {
    String index = (i+1).toString();
    
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: kRed,
                foregroundColor: Colors.white,
                radius: SizeConfig.blockSizeHorizontal * 4,
                child: Text(index, style: TextStyle(
                  fontSize: kActionButtonTextSize,
                  fontWeight: FontWeight.bold
                )),
              ),
              SizedBox(width: 12.0),
              Text(itemOptionToString(itemOption), style: TextStyle(
                fontSize: kActionButtonTextSize,
                fontWeight: FontWeight.w500
              ))
            ],
          ),
          _buildOptionItemsList(itemOption)
        ],
      ),
    );
  }

  Widget _buildOptionItemsList(ItemOption itemOption) {
    List<OptionCategory> _optionCategories;

    switch (itemOption) {
      case ItemOption.Drink:
        _optionCategories = _model.getDrinks();
        break;
      case ItemOption.AddOn:
        _optionCategories = _model.getAddOns();
        break;
    }

    // TODO
    return Column(
      children: <Widget>[
        PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Row(
            children: _optionCategories.map((OptionCategory category) => _buildOptionItemCategory(category.name)).toList()
          ),
        )
      ],
    );

    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount: _optionCategories,
    //   itemBuilder: (BuildContext context, int i ) => OptionItemTile(
    //     item: 
    //   ),
    // );
  }

  Widget _buildOptionItemCategory(String name) {
    return Container(
      child: Text(name)
    );
  }
}

class OptionItemTile extends StatefulWidget {
  OptionItemTile({
    this.item
  });

  final OptionItem item;

  @override
  OptionItemTileState createState() => OptionItemTileState();
}

class OptionItemTileState extends State<OptionItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}