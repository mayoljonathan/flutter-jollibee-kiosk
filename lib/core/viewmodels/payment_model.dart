import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:jollibee_kiosk/core/models/option_category.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';
import 'package:jollibee_kiosk/core/dto/order_dto.dart';
import 'package:jollibee_kiosk/core/services/menu_service.dart';

enum PaymentViewStep {
  SERVICE_MODE, // Dine In/Takeout
  PAYMENT_TYPE, // PAY_HERE/AT_COUNTER
  // PAYMENT_METHOD, //Debit/Credit, Happyplus Card, Cash
  PROCESSING //Loading
}

enum ServiceMode { DINE_IN, TAKE_OUT }
enum PaymentType { PAY_HERE, AT_COUNTER }
// enum PaymentMethod { CASH }

class PaymentModel extends BaseModel {

  PaymentViewStep _paymentViewStep = PaymentViewStep.SERVICE_MODE;
  PaymentViewStep get paymentViewStep => _paymentViewStep;
  set paymentViewStep(PaymentViewStep step) {
    _paymentViewStep = step;
    notifyListeners();
  }

  OrderDto orderDto = OrderDto();

}