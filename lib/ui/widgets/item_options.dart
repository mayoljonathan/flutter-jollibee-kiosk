import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/viewmodels/menu_model.dart';
import 'package:jollibee_kiosk/ui/shared/clippers/triangle_clipper.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';
import 'package:jollibee_kiosk/ui/widgets/option_item_tile_list.dart';

enum ItemOption { Drink, AddOn }

class ItemOptions extends StatefulWidget {
  ItemOptions({
    this.hasDrinks = false,
    this.hasAddOns = false,
    this.maxDrinkSelection = 1,
    this.maxAddOnSelection = 1,
  });

  final bool hasDrinks;
  final bool hasAddOns;
  final int maxDrinkSelection;
  final int maxAddOnSelection;

  @override
  _ItemOptionsState createState() => _ItemOptionsState();
}

class _ItemOptionsState extends State<ItemOptions> {

  MenuModel _model;
  List<ItemOption> _itemOptions = [];

  Map<ItemOption, int> _selectedIndices = {};

  @override
  void initState() {
    super.initState();
    if (widget.hasDrinks) _itemOptions.add(ItemOption.Drink);
    if (widget.hasAddOns) _itemOptions.add(ItemOption.AddOn);

    _selectedIndices = {
      ItemOption.Drink: 0,
      ItemOption.AddOn: 0
    };
  }

  String itemOptionToString(ItemOption itemOption) {
    String optionName = '';

    switch (itemOption) {
      case ItemOption.Drink:
        String hintMessage = '';
        if (widget.maxDrinkSelection > 1) hintMessage = '(Select up to ${widget.maxDrinkSelection})';

        optionName = 'Drinks $hintMessage';
        break;
      case ItemOption.AddOn:
        String hintMessage = '';
        if (widget.maxAddOnSelection > 1) hintMessage = '(Select up to ${widget.maxAddOnSelection})';

        optionName = 'Add-On $hintMessage';
        break;
    }
    return optionName;
  }

  @override
  Widget build(BuildContext context) {
    if (_itemOptions.length == 0 ) return Container();

    return BaseView<MenuModel>(
      onModelReady: (MenuModel model) => _model = model,
      builder: (context, model, child) => Column(
        children: _itemOptions.asMap().map((i, ItemOption option) => MapEntry(i, _buildOption(i, option))).values.toList()
      )
    );
  }

  Widget _buildOption(int i, ItemOption itemOption) {
    String index = (i+1).toString();
    List<OptionCategory> _optionCategories;

    switch (itemOption) {
      case ItemOption.Drink:
        _optionCategories = _model.getDrinks();
        break;
      case ItemOption.AddOn:
        _optionCategories = _model.getAddOns();
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: CircleAvatar(
                        backgroundColor: kRed,
                        foregroundColor: Colors.white,
                        radius: SizeConfig.blockSizeHorizontal * 3,
                        child: Text(index, style: TextStyle(
                          fontSize: kActionButtonTextSize,
                          fontWeight: FontWeight.bold
                        )),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(itemOptionToString(itemOption), style: TextStyle(
                        fontSize: kActionButtonTextSize,
                        fontWeight: FontWeight.w500
                      )),
                    ),
                  ],
                ),
              ),
              _buildOptionTilesList(itemOption)
            ],
          ),
          OptionItemTileList(
            key: ValueKey(_optionCategories[_selectedIndices[itemOption]].id),
            itemOption: itemOption,
            optionCategory: _optionCategories[_selectedIndices[itemOption]],
            maxDrinkSelection: widget.maxDrinkSelection,
            maxAddOnSelection: widget.maxAddOnSelection,
          )
        ],
      ),
    );
  }

  Widget _buildOptionTilesList(ItemOption itemOption) {
    List<OptionCategory> _optionCategories;

    switch (itemOption) {
      case ItemOption.Drink:
        _optionCategories = _model.getDrinks();
        break;
      case ItemOption.AddOn:
        _optionCategories = _model.getAddOns();
        break;
    }

    return Row(
      children: _optionCategories.asMap().map((int i, OptionCategory category) {
        bool isSelected = _selectedIndices[itemOption] == i;
        return MapEntry(i, _buildOptionItemCategory(category.name, 
          itemOption: itemOption,
          index: i,
          isSelected: isSelected
        ));
      }).values.toList()
    );
  }

  Widget _buildOptionItemCategory(String name, {ItemOption itemOption, int index, bool isSelected}) {
    return Stack(
      children: <Widget>[
        CustomBouncingContainer(
          onTap: () => setState(() => _selectedIndices[itemOption] = index),
          child: Container(
            height: 60,
            color: Colors.transparent,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(name, style: TextStyle(
                  fontSize: kBodyTextSize,
                  color: isSelected ? kRed : kPrimaryTextColor 
                )),
              ),
            ),
          ),
        ),
        isSelected ? Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Transform.rotate(
              angle: -math.pi / 1,
              child: ClipPath(
                clipper: TriangleClipper(),
                child: Container(
                  height: 20,
                  width: 20,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ),
        ) : Container(height: 0, width: 0)
      ],
    );
  }
}