import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/viewmodels/payment_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:provider/provider.dart';

class PaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: ListenableProvider(
          builder: (BuildContext context) => locator<PaymentModel>(),
          child: Consumer<PaymentModel>(
            builder: (context, model, child) {
              Widget widget = Container();

              switch (model.paymentViewStep) {
                case PaymentViewStep.ServiceMode:
                  widget = _buildServiceMode();
                  break;
                case PaymentViewStep.PaymentMethod:
                  widget = _buildPaymentMethod();
                  break;
              }

              return widget;
            }
          )
        )
      ),
    );
  }

  // TODO
  Widget _buildServiceMode() {
    return Text('Service Mode');
  }

  Widget _buildPaymentMethod() {
    return Text('Payment Method');
  }


}