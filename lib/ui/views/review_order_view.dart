import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/my_order_list.dart';
import 'package:jollibee_kiosk/ui/widgets/order_total.dart';

class ReviewOrderView extends StatelessWidget {
  ReviewOrderView({Key key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(),
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
            width: SizeConfig.blockSizeHorizontal * 20,
            child: Hero(
              tag: 'jollibee_logo',
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/jollibee_icon.png'),
              )
            ),
          ),
          Text('Review your Order' , style: TextStyle(
            fontSize: kTitleTextSize,
            fontWeight: FontWeight.bold
          )),
        ],
      )
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          // Hero(
          //   tag: 'header-title',
          //   child: Material(
          //     color: Colors.transparent,
          //     child: _buildHeader()
          //   )
          // ),
          _buildHeader(),
          Divider(height: 1.0),
          Expanded(
            child: Container(
              color: kCanvasColor,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListenableProvider(
                    builder: (BuildContext context) => locator<MyCartModel>(),
                    child: Consumer<MyCartModel>(
                      builder: (context, model, child) {
                        return Hero(
                          tag: 'order-title',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(model.getMyOrderTitle(), style: TextStyle(
                              fontSize: kSubheadTextSize,
                              fontWeight: FontWeight.w500
                            )),
                          ),
                        );
                      }
                    )
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: MyOrderList(animatedListKeyIndex: 1)
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(height: 1.0),
        SizedBox(
          height: 144,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: _buildActionButtonItem(context, text: 'Go Back')
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                Expanded(
                  child: OrderTotal()
                ),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 3),
                Expanded(
                  child: ListenableProvider(
                    builder: (BuildContext context) => locator<MyCartModel>(),
                    child: Consumer<MyCartModel>(
                      builder: (context, model, child) => _buildActionButtonItem(context, 
                        text: 'Proceed To Payment', 
                        color: model.items.length == 0 ? kGrey : kGreen,
                        onTap: () => this._onProceedToPayment(context)
                      )
                    )
                  )
                )
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return Hero(
      tag: text,
      child: Material(
        type: MaterialType.transparency,
        child: CustomBouncingContainer(
          onTap: onTap == null ? () => Navigator.pop(context) : onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: color,
            ),
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Text(text, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: kActionButtonTextSize,
                  fontWeight: FontWeight.bold
                )
              ),
            )
          )
        ),
      ),
    );
  }

  void _onProceedToPayment(context) {
    if (Provider.of<MyCartModel>(context).items.length == 0) return;

    Navigator.pushNamed(context, '/payment');
  }
}