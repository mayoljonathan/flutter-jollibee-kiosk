import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/services/order_service.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';

import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';
import 'package:jollibee_kiosk/core/dto/order_dto.dart';

enum PaymentViewStep {
  SERVICE_MODE, // Dine In/Takeout
  PAYMENT_TYPE, // PAY_HERE/AT_COUNTER
  // PAYMENT_METHOD, //Debit/Credit, Happyplus Card, Cash
  PROCESSING, //Loading
  ORDER_FAILED
}

enum ServiceMode { DINE_IN, TAKE_OUT }
enum PaymentType { PAY_HERE, AT_COUNTER }
// enum PaymentMethod { CASH }

class PaymentModel extends BaseModel {
  MyCartModel _myCartModel = locator<MyCartModel>();
  OrderService _orderService = locator<OrderService>();

  OrderDto orderDto = OrderDto();
  AnimationController animationController;

  PaymentViewStep _paymentViewStep = PaymentViewStep.SERVICE_MODE;
  PaymentViewStep get paymentViewStep => _paymentViewStep;
  set paymentViewStep(PaymentViewStep step) {
    _paymentViewStep = step;
    notifyListeners();
  }

  void onPaymentTypeTap(BuildContext context, PaymentType paymentType) async {
    await animationController.reverse();
    paymentViewStep = PaymentViewStep.PROCESSING;
    orderDto.paymentType = PaymentType.AT_COUNTER;
    animationController.forward();
    sendOrder(context);
  }

  void sendOrder(BuildContext context) async {
    orderDto.items = _myCartModel.items;
    orderDto.totalPrice = _myCartModel.getOrderTotal();

    bool success = await _orderService.sendOrder(orderDto);
    if (success) {
      Navigator.pushNamedAndRemoveUntil(context, '/order-completed', (Route<dynamic> route) => false);
    } else {
      await animationController.reverse();
      paymentViewStep = PaymentViewStep.ORDER_FAILED;
      await animationController.forward();
    }
  }


}