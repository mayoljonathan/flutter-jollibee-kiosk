import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:transparent_image/transparent_image.dart';

class OrderCompletedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/entry', (Route<dynamic> route) => false);
        return false;
      },
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
              width: SizeConfig.blockSizeHorizontal * 20,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/jollibee_icon.png'),
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
                  child: _buildCardContent()
                ),
              ),
            ),
            SizedBox(height: 64.0),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 30,
              child: _buildActionButtonItem(context, 
                text: 'Order Again', 
                onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/entry', (Route<dynamic> route) => false)
              )
            )
          ],
        )
      )
    );
  }

  Widget _buildCardContent() {
    return Column(
      children: <Widget>[
        Text('Thank you!', style: TextStyle(
          fontSize: kTitleTextSize,
          fontWeight: FontWeight.bold
        )),
        SizedBox(height: 64.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildStepItem(1, 'Take your receipt from the machine', 'assets/images/receipt.png'),
            _buildStepItem(2, 'Give the receipt to the cashier', 'assets/images/cashier.png'),
          ],
        )
      ],
    );
  }

  Widget _buildStepItem(int index, String label, String imagePath) {
    return Container(
      width: (SizeConfig.blockSizeHorizontal * 30) - 64,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                child: Image.asset(imagePath),
              ),
              Text(label, 
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: kBodyTextSize
                )
              )
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 1.5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kRed
              ),
              child: Text(index.toString(), style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: kBodyTextSize
              ))
            )
          ),
        ],
      )
    );
  }

  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return Material(
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
    );
  }
}