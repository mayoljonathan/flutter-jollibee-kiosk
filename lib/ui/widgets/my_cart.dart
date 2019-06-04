import 'package:flutter/material.dart';

import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/theme.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 30,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.elliptical(40.0, 20.0),
          //   topRight: Radius.elliptical(40.0, 20.0),
          // ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -5.0),
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1, 
              blurRadius: 12.0,
            )
          ],
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('My Order', style: TextStyle(
            fontSize: kSubheadTextSize
          ))
        ],
      )
    );
  }
}