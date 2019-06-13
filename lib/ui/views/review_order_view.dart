import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/viewmodels/my_cart_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/my_order_list.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

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
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage('assets/images/jollibee_icon.png'),
            )
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
          Hero(
            tag: 'header-title',
            child: Material(
              color: Colors.transparent,
              child: _buildHeader()
            )
          ),
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
                        String text = 'My Order';
                        if (model.items.length > 0) {
                          if (model.items.length == 1) text += ' (1 item)';
                          else text += ' (${model.getTotalItemsIncludeItemQty()} items)';
                        } 

                        return Hero(
                          tag: 'order-title',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(text, style: TextStyle(
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
                SizedBox(width: 48),
                Expanded(
                  child: _buildOrderTotal()
                ),
                SizedBox(width: 48),
                Expanded(
                  child: _buildActionButtonItem(context, 
                    text: 'Proceed To Payment', 
                    color: kGreen
                  ),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return CustomBouncingContainer(
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
              fontSize: kActionButtonTextSize
            )
          ),
        )
      )
    );
  }

  Widget _buildOrderTotal() {
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