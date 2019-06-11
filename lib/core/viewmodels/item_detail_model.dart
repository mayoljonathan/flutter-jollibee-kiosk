import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:jollibee_kiosk/core/models/cart.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/locator.dart';

import 'package:jollibee_kiosk/ui/shared/ui_helper.dart';
import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
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
  bool isEditing = false;

  int _quantity = 1; // Number of items for this meal
  int get quantity => _quantity;
  set quantity(int quantity) {
    _quantity = quantity;
    notifyListeners();
  }
  
  // PUBLIC METHODS

  /// Call this function when editting the order item in cart
  void setInitialValues({
    @required Map<ItemOption, List<OptionItemCart>> optionSelections,
    @required MenuItem selectedMenuItem,
    @required int quantity,
    @required bool isEditing,
  }) {
    this._optionSelections = optionSelections;
    this.selectedMenuItem = selectedMenuItem;
    this._quantity = quantity ?? 1;
    this.isEditing = isEditing ?? false;
  }

  int getOptionItemSelectedCount(ItemOption itemOption, OptionItem optionItem) {
    OptionItemCart oic = _getOptionItemCart(itemOption, optionItem);
    return oic == null ? 0 : oic.quantity;
  }

  double getMealTotal() {
    double mealTotal = 0;
    mealTotal += selectedMenuItem.price;

    _optionSelections[ItemOption.Drink].forEach((OptionItemCart oic) {
      if (oic.price != null) mealTotal += oic.price * oic.quantity;
    });

    _optionSelections[ItemOption.AddOn].forEach((OptionItemCart oic) {
      if (oic.price != null) mealTotal += oic.price * oic.quantity;
    });

    return mealTotal * quantity;
  }

  String getMealTotalToString() {
    final formatter = NumberFormat.simpleCurrency(name: '', decimalDigits: 2);
    return '₱ ${formatter.format(getMealTotal())}';
  }

  void onOptionItemTileTap(BuildContext context, ItemOption itemOption, OptionItem optionItem) async {
    // If maxSelections are more than 1, then open a quantity picker
    if (itemOption == ItemOption.Drink && 
        this.selectedMenuItem.maxDrinkSelection != null && 
        this.selectedMenuItem.maxDrinkSelection > 1) {
      if (!_canUpdateQuantityOptionItemTile(itemOption, optionItem)) {
        UIHelper.showNiceToast(context, title: 'Maximum drinks selected', subTitle: 'You already had selected ${_getTotalSelectedQuantityInItemOption(itemOption)} drinks. Remove other drinks to select this drink.');
        return;
      }

      int qty = await this._navigateOptionItemQtyPicker(context, itemOption, optionItem);
      if (qty != null) _updateOptionSelections(itemOption, optionItem, quantity: qty);
      return;

    } else if (itemOption == ItemOption.AddOn && 
      this.selectedMenuItem.maxAddOnSelection != null && 
      this.selectedMenuItem.maxAddOnSelection > 1) {

      if (!_canUpdateQuantityOptionItemTile(itemOption, optionItem)) {
        UIHelper.showNiceToast(context, title: 'Maximum add-ons selected', subTitle: 'You already had selected ${_getTotalSelectedQuantityInItemOption(itemOption)} add-ons. Remove other add-ons to select this add-on.');
        return;
      }

      int qty = await this._navigateOptionItemQtyPicker(context, itemOption, optionItem);
      if (qty != null) _updateOptionSelections(itemOption, optionItem, quantity: qty);
      return;
    }

    // Otherwise toggle between other optionItems
    // Toggle add/remove it from optionSelections
    if (!_hasSelectedOptionItem(itemOption, optionItem)) {
      // Clear first the other selected item in this ItemOption
      _clearItemOptionSelection(itemOption);
      _addToOptionSelections(itemOption, optionItem);
    } else {
      _updateOptionSelections(itemOption, optionItem, quantity: 0);
    }
  }

  void onAddMenuItemToOrder(BuildContext context) {
    final mic = MenuItemCart(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      quantity: _quantity,
      menuItem: selectedMenuItem,
      drinks: _optionSelections[ItemOption.Drink],
      addOns: _optionSelections[ItemOption.AddOn],
    );

    MyCartModel myCartModel = locator<MyCartModel>();
    myCartModel.addMenuItem(mic);
    Navigator.of(context).pop();
  }

  void onUpdateMenuItemFromOrder(BuildContext context, {String id}) {
    final mic = MenuItemCart(
      id: id,
      quantity: _quantity,
      menuItem: selectedMenuItem,
      drinks: _optionSelections[ItemOption.Drink],
      addOns: _optionSelections[ItemOption.AddOn],
    );

    MyCartModel myCartModel = locator<MyCartModel>();
    myCartModel.updateMenuItem(mic);
    Navigator.of(context).pop();
  }

  // PRIVATE
  void _clearItemOptionSelection(ItemOption itemOption) {
    _optionSelections[itemOption] = [];
  }

  bool _canUpdateQuantityOptionItemTile(ItemOption itemOption, OptionItem optionItem) {
    if (_hasSelectedOptionItem(itemOption, optionItem)) return true;

    int totalSelectedQuantity = _getTotalSelectedQuantityInItemOption(itemOption);

    if ((itemOption == ItemOption.Drink &&
        totalSelectedQuantity >= selectedMenuItem.maxDrinkSelection) ||
        (itemOption == ItemOption.AddOn &&
        totalSelectedQuantity >= selectedMenuItem.maxAddOnSelection)
    ) return false;
    return true;
  }

  int _getTotalSelectedQuantityInItemOption(ItemOption itemOption) {
    int totalSelectedQuantity = 0;
    if (_optionSelections[itemOption].length > 0) {
      _optionSelections[itemOption].forEach((OptionItemCart oic) => totalSelectedQuantity = totalSelectedQuantity+oic.quantity);
    }
    return totalSelectedQuantity;
  }

  int _getAvailableMaxQuantity(ItemOption itemOption, OptionItem optionItem) {
    int availableMaxQuantity = 1;
    int totalSelectedQuantity = _getTotalSelectedQuantityInItemOption(itemOption);
    
    if (itemOption == ItemOption.Drink) {
      availableMaxQuantity = selectedMenuItem.maxDrinkSelection - totalSelectedQuantity;
    } else if(itemOption == ItemOption.AddOn) {
      availableMaxQuantity = selectedMenuItem.maxAddOnSelection - totalSelectedQuantity;
    }

    OptionItemCart oic = _getOptionItemCart(itemOption, optionItem);
    if (oic?.id == optionItem.id) availableMaxQuantity += oic?.quantity;

    print(availableMaxQuantity);
    return availableMaxQuantity;
  }

  /// Returns the number of desired quantity of the selected item
  Future<int> _navigateOptionItemQtyPicker(BuildContext context, ItemOption itemOption, OptionItem optionItem) async {
    int initialQuantity = 1;
    OptionItemCart oic = _getOptionItemCart(itemOption, optionItem);
    if (oic != null) initialQuantity = oic.quantity;

    var qty = await Navigator.pushNamed(context, '/option-item-quantity-picker', arguments: {
      "optionItem" : optionItem,
      "initialQuantity": initialQuantity,
      "maxQuantity": _getAvailableMaxQuantity(itemOption, optionItem)
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
      name: optionItem.name,
      price: optionItem.price,
      quantity: quantity
    ));

    notifyListeners();
  }

  void _updateOptionSelections(ItemOption itemOption, OptionItem optionItem, {@required int quantity}) {
    if (quantity == 0) {
      _optionSelections[itemOption].removeWhere((OptionItemCart oic) => oic.id == optionItem.id);
    } else {
      if (!_hasSelectedOptionItem(itemOption, optionItem)) {
        _addToOptionSelections(itemOption, optionItem, quantity: quantity);
      } else {
        OptionItemCart oic = _getOptionItemCart(itemOption, optionItem);
        oic.quantity = quantity;
      }
    }
    notifyListeners();
  }

}