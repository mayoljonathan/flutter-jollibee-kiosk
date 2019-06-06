import 'package:jollibee_kiosk/ui/widgets/item_options.dart';
import 'package:jollibee_kiosk/ui/widgets/option_item_tile_list.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

class ItemDetailModel extends BaseModel {

  // int _maxDrinkSelection = 1;
  // int get maxDrinkSelection => _maxDrinkSelection;
  // set maxDrinkSelection(int val) {
  //   _maxDrinkSelection = val;
  //   notifyListeners();
  // }

  // int _maxAddOnSelection = 1;
  // int get maxAddOnSelection => _maxAddOnSelection;
  // set maxAddOnSelection(int val) {
  //   _maxAddOnSelection = val;
  //   notifyListeners();
  // }


  Map<ItemOption, List<OptionItemCart>> _optionSelections;

  ItemDetailModel() {
    _optionSelections = {
      ItemOption.Drink: [],
      ItemOption.AddOn: [],
    };
  }

  int getOptionItemSelectedCount(OptionItem optionItem) {
    OptionItemCart oic = _optionSelections[ItemOption.Drink].firstWhere((OptionItemCart oic) => oic.id == optionItem.id, 
      orElse: () => null
    );
    return oic == null ? 0 : oic.quantity;
  }

  void onOptionItemTileTap(ItemOption itemOption, OptionItem optionItem) {
    if (!_hasSelectedOptionItem(optionItem)) _addToOptionSelections(itemOption, optionItem);
    notifyListeners();
  }

  void _addToOptionSelections(ItemOption itemOption, OptionItem optionItem) {
    _optionSelections[itemOption].add(OptionItemCart(
      id: optionItem.id,
      price: optionItem.price,
      quantity: 1
    ));
  }

  bool _hasSelectedOptionItem(OptionItem optionItem) {
    if (_optionSelections[ItemOption.Drink].length > 0) {
      OptionItemCart oic = _optionSelections[ItemOption.Drink].firstWhere((OptionItemCart oic) => oic.id == optionItem.id, 
        orElse: () => null
      );
      return oic == null ? false : true;
    } else if (_optionSelections[ItemOption.AddOn].length > 0) {
      OptionItemCart oic = _optionSelections[ItemOption.AddOn].firstWhere((OptionItemCart oic) => oic.id == optionItem.id, 
        orElse: () => null
      );
      return oic == null ? false : true;
    } else {
      return false;
    }
  }

}