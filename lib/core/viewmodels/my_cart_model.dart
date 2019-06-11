import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jollibee_kiosk/core/viewmodels/item_detail_model.dart';
import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/core/models/cart.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

class MyCartModel extends BaseModel {
  List<MenuItemCart> _items = [];
  List<MenuItemCart> get items => _items;

  ScrollController scrollController = ScrollController();

  double getOrderTotal() {
    double total = 0;
    if (_items.length > 0) _items.forEach((MenuItemCart mic) => total += getTotalPricePerMenuItemCart(mic));
    return total;
  }

  String getOrderTotalToString() {
    final formatter = NumberFormat.simpleCurrency(name: '', decimalDigits: 2);
    return '₱ ${formatter.format(getOrderTotal())}';
  }

  double getTotalPricePerMenuItemCart(MenuItemCart mic) {
    double overallTotal = 0;
    double totalMealPrice = 0;
    double totalDrinksPrice = 0;
    double totalAddOnsPrice = 0;
    mic.drinks?.forEach((OptionItemCart oic) => totalDrinksPrice += ((oic.price ?? 0) * oic.quantity));
    mic.addOns?.forEach((OptionItemCart oic) => totalAddOnsPrice += ((oic.price ?? 0) * oic.quantity));
    
    totalMealPrice += mic.menuItem.price + totalDrinksPrice + totalAddOnsPrice;
    overallTotal = totalMealPrice * mic.quantity;

    return overallTotal;
  }

  String getTotalPricePerMenuItemCartToString(MenuItemCart mic) {
    final formatter = NumberFormat.simpleCurrency(name: '', decimalDigits: 2);
    return '₱ ${formatter.format(getTotalPricePerMenuItemCart(mic))}';
  }

  int getTotalItemsIncludeItemQty() {
    int total = 0;
    _items.forEach((MenuItemCart mic) => total += mic.quantity);
    return total;
  }
  
  void addMenuItem(MenuItemCart mic) {
    Future.delayed(Duration(milliseconds: 350), () {
      _items.add(mic);

      if (scrollController != null && scrollController.hasClients) {
        Future.delayed(Duration(milliseconds: 100), () {
          scrollController.animateTo(scrollController.position.maxScrollExtent, 
            duration: Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn
          );
        });

      }
      notifyListeners();
    });
  }

  void updateMenuItem(MenuItemCart mic) {
    int index = _items.indexWhere((MenuItemCart item) => item.id == mic.id);
    if (index != -1) {
      Future.delayed(Duration(milliseconds: 350), () {
        _items[index] = mic;
        notifyListeners();
      });
    }
  }

  void removeMenuItem(MenuItemCart mic) {
    _items.remove(mic);
    notifyListeners();
  }

  void onEditMenuItem(BuildContext context, MenuItemCart mic) {
    Navigator.pushNamed(context, '/item-detail', arguments: {
      'heroTag': mic.id,
      'item': mic.menuItem,
      'optionSelections': {
        ItemOption.Drink: mic.drinks,
        ItemOption.AddOn: mic.addOns
      },
      'quantity': mic.quantity,
      'isEditing': true
    });
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }
}