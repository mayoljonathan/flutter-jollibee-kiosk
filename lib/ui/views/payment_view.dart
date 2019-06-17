import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:jollibee_kiosk/ui/shared/loader/color_loader_3.dart';
import 'package:provider/provider.dart';

import 'package:jollibee_kiosk/core/viewmodels/payment_model.dart';
import 'package:jollibee_kiosk/locator.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/widgets/order_total.dart';
import 'package:transparent_image/transparent_image.dart';

class PaymentView extends StatefulWidget {
  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> with TickerProviderStateMixin {

  AnimationController _cardContainerAnimationController;            
  Animation<double> _cardContainerAnimation;

  PaymentModel _model;

  @override
  void initState() {
    super.initState();
    _cardContainerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400), 
      vsync: this,
      lowerBound: 0.1,
      upperBound: 1
    );            

    _cardContainerAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _cardContainerAnimationController,
      curve:  Curves.fastOutSlowIn,
      reverseCurve: Curves.fastOutSlowIn
    ));

    _cardContainerAnimationController.addListener(() => setState(() {}));
    _cardContainerAnimationController.forward();
  }

  @override
  void dispose() {
    _cardContainerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this._onGoBackTap,
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: _buildBottomBar(context),
      ),
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
              _model = model;
              Widget widget = Container();

              switch (model.paymentViewStep) {
                case PaymentViewStep.SERVICE_MODE:
                  widget = _buildServiceMode();
                  break;
                case PaymentViewStep.PAYMENT_TYPE:
                  widget = _buildPaymentMethod();
                  break;
                case PaymentViewStep.PROCESSING:
                  widget = _buildProcessingLayout();
                  break;
              }
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: 24.0),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 80,
                    child: Card(
                      elevation: 16,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
                        child: Transform.scale(
                          scale: _cardContainerAnimation.value,
                          child: AnimatedOpacity(
                            opacity: _cardContainerAnimation.value,
                            duration: Duration(milliseconds: 200),
                            child: AnimatedSize(
                              duration: Duration(milliseconds: 350),
                              vsync: this,
                              curve: Curves.fastOutSlowIn,
                              child: widget,
                            )
                          )
                        )
                      ),
                    ),
                  )
                ],
              );
            }
          )
        )
      ),
    );
  }

  Widget _buildServiceMode() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Where will you be eating today?', 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: kTitleTextSize,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(height: 64),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildServiceModeChoiceItem('Dine-in', 'assets/images/dine_in.png', 
              onTap: () async {
                await _cardContainerAnimationController.reverse();
                _model.paymentViewStep = PaymentViewStep.PAYMENT_TYPE;
                _model.orderDto.serviceMode = ServiceMode.DINE_IN;
                _cardContainerAnimationController.forward();
              } 
            ),
            _buildServiceModeChoiceItem('Take-out', 'assets/images/take_out.png',
              onTap: () async {
                await _cardContainerAnimationController.reverse();
                _model.paymentViewStep = PaymentViewStep.PAYMENT_TYPE;
                _model.orderDto.serviceMode = ServiceMode.TAKE_OUT;
                _cardContainerAnimationController.forward();
              }
            ),
          ],
        )
      ],
    );
  }

  Widget _buildServiceModeChoiceItem(String label, String imagePath, {VoidCallback onTap}) {
    return CustomBouncingContainer(
      onTap: onTap,
      child: Container(
        width: (SizeConfig.blockSizeHorizontal * 40) - 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 3.0,
          )
        ),
        padding: const EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(imagePath),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0)
                ),
                color: kRed,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Text(label, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: kSubheadTextSize,
                  fontWeight: FontWeight.w500
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('How would you like to pay?', 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: kTitleTextSize,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(height: 64),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildServiceModeChoiceItem('At Counter', 'assets/images/at_counter.png',
              onTap: () async {
                await _cardContainerAnimationController.reverse();
                _model.paymentViewStep = PaymentViewStep.PROCESSING;
                _model.orderDto.paymentType = PaymentType.AT_COUNTER;
                _cardContainerAnimationController.forward();
              }
            ),
          ],
        )
      ],
    );
  }

  Widget _buildProcessingLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ColorLoader3(
          centerDotColor: Colors.red,
          radius: SizeConfig.blockSizeHorizontal * 5,
          dotRadius: SizeConfig.blockSizeHorizontal * 2,
          outsideDotColors: [
            kRed,
            kYellow,
            kRed,
            kYellow,
            kRed,
            kYellow,
            kRed,
            kYellow,
          ],
        ),
        SizedBox(height: 24.0),
        Text('Processing. Please wait.', style: TextStyle(
          fontSize: kTitleTextSize
        ))
      ],
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
              children: <Widget>[
                Expanded(
                  child: _buildActionButtonItem(context, text: _model?.paymentViewStep == PaymentViewStep.PROCESSING ? 'Cancel' : 'Go Back', onTap: this._onGoBackTap)
                ),
                Spacer(),
                Expanded(
                  child: OrderTotal()
                ),
              ],
            ),
          )
        ),
      ],
    );
  }

  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return Hero(
      tag: 'Go Back',
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

  Future<bool> _onGoBackTap() async {
    PaymentViewStep step = _model.paymentViewStep;

    switch (step) {
      case PaymentViewStep.SERVICE_MODE:
        Navigator.of(context).pop();
        break;
      case PaymentViewStep.PAYMENT_TYPE:
        await _cardContainerAnimationController.reverse();
        _model.paymentViewStep = PaymentViewStep.SERVICE_MODE;
        _cardContainerAnimationController.forward();
        break;
      case PaymentViewStep.PROCESSING:
        await _cardContainerAnimationController.reverse();
        _model.paymentViewStep = PaymentViewStep.PAYMENT_TYPE;
        _cardContainerAnimationController.forward();
        break;
    }
    return false;
  }
}