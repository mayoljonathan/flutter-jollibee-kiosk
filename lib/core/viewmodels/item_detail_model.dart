import 'package:flutter/widgets.dart';
import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:jollibee_kiosk/ui/widgets/option_item_tile_list.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

class ItemDetailModel extends BaseModel {
  ItemDetailModel() {
    _optionSelections = {
      ItemOption.Drink: [],
      ItemOption.AddOn: [],
    };
  }

  MenuItem selectedMenuItem;
  Map<ItemOption, List<OptionItemCart>> _optionSelections;

  // PUBLIC METHODS
  int getOptionItemSelectedCount(ItemOption itemOption, OptionItem optionItem) {
    OptionItemCart oic = _getOptionItemCart(itemOption, optionItem);
    return oic == null ? 0 : oic.quantity;
  }

  void onOptionItemTileTap(BuildContext context, ItemOption itemOption, OptionItem optionItem) async {
    // If maxSelections are more than 1, then open a quantity picker
    if (itemOption == ItemOption.Drink && 
        this.selectedMenuItem.maxDrinkSelection != null && 
        this.selectedMenuItem.maxDrinkSelection > 1) {
      int qty = await this._navigateOptionItemQtyPicker(context, itemOption, optionItem);
      if (qty != null) _updateOptionSelections(itemOption, optionItem, quantity: qty);
      return;

    } else if (itemOption == ItemOption.AddOn && 
      this.selectedMenuItem.maxAddOnSelection != null && 
      this.selectedMenuItem.maxAddOnSelection > 1) {

      int qty = await this._navigateOptionItemQtyPicker(context, itemOption, optionItem);
      if (qty != null) _updateOptionSelections(itemOption, optionItem, quantity: qty);
      return;
    }

    // Toggle add/remove it from optionSelections
    if (!_hasSelectedOptionItem(itemOption, optionItem)) {
      _addToOptionSelections(itemOption, optionItem);
    } else {
      _updateOptionSelections(itemOption, optionItem, quantity: 0);
    }
  }

  void onAddMenuItemToOrder(MenuItem item) {
    print('onAddMenuItemToOrder');
    print(selectedMenuItem);

    // print(item);
    print(_optionSelections[ItemOption.Drink]);
    print(_optionSelections[ItemOption.AddOn]);
  }

  // PRIVATE

  /// Returns the number of desired quantity of the selected item
  // Future<int> _navigateOptionItemQtyPicker(BuildContext context, OptionItem optionItem) async {
  //   int quantity = await Navigator.pushNamed(context, '/option-item-quantity-picker', arguments: optionItem);
  //   return quantity;
  // }
  Future<int> _navigateOptionItemQtyPicker(BuildContext context, ItemOption itemOption, OptionItem optionItem) async {
    var qty = await Navigator.pushNamed(context, '/option-item-quantity-picker', arguments: {
      "optionItem" : optionItem,
      "maxQuantity": itemOption == ItemOption.Drink ? selectedMenuItem.maxDrinkSelection : selectedMenuItem.maxAddOnSelection
    });
    return qty;
  }

  OptionItemCart _getOptionItemCart(ItemOption itemOption, OptionItem optionItem) {
    return _optionSelections[itemOption].firstWhere((OptionItemCart oic) => oic.id == optionItem.id, 
      orElse: () => null
    );
  }

  bool _hasSelectedOptionItem(ItemOption itemOption, OptionItem optionItem) {
    if (_optionSelections[itemOption].length > 0) {
      OptionItemCart oic = _getOptionItemCart(itemOption, optionItem);
      return oic == null ? false : true;
    } else {
      return false;
    }
  }
  
  void _addToOptionSelections(ItemOption itemOption, OptionItem optionItem, {int quantity = 1}) {
    _optionSelections[itemOption].add(OptionItemCart(
      id: optionItem.id,
      price: optionItem.price,
      quantity: quantity
    ));

    notifyListeners();
  }

  void _updateOptionSelections(ItemOption itemOption, OptionItem optionItem, {@required int quantity}) {
    if (quantity == 0) {
      _optionSelections[itemOption].removeWhere((OptionItemCart oic) => oic.id == optionItem.id);
    } else {
      OptionItemCart oic = _getOptionItemCart(itemOption, optionItem);
      oic.quantity = quantity;
    }

    notifyListeners();
  }

}