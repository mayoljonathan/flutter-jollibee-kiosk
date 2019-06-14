import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

enum PaymentViewStep {
  ServiceMode, // Dine In/Takeout
  PaymentMethod, //Debit/Credit, Happyplus Card, Cash
}

class PaymentModel extends BaseModel {

  PaymentViewStep _paymentViewStep = PaymentViewStep.ServiceMode;
  PaymentViewStep get paymentViewStep => _paymentViewStep;
  set paymentViewStep(PaymentViewStep step) {
    _paymentViewStep = step;
    notifyListeners();
  }

}