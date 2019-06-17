import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';

class OrderTotal extends StatelessWidget {
  OrderTotal({Key key}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      builder: (BuildContext context) => locator<MyCartModel>(),
      child: Consumer<MyCartModel>(
        builder: (context, model, child) => Hero(
          tag: 'order-total',
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: kRed,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(9.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text('Order Total', style: TextStyle(
                    fontSize: kActionButtonTextSize,
                  )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(Provider.of<MyCartModel>(context).getOrderTotalToString(), style: TextStyle(
                        fontSize: kSubheadTextSize,
                        fontWeight: FontWeight.bold
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}