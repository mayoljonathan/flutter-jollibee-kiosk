import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';

import 'package:jollibee_kiosk/ui/shared/size_config.dart';

// This view is just for initializing the SizeConfig
class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with AfterLayoutMixin<SplashView> {
  @override
  void afterFirstLayout(BuildContext context) {
    SizeConfig.init(context);
    Navigator.pushReplacementNamed(context, '/entry');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(),
      ),
    );
  }

}