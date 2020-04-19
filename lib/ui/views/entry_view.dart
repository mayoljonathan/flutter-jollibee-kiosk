import 'package:flutter/material.dart';
import 'package:jollibee_kiosk/core/models/menu.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:jollibee_kiosk/locator.dart';

import 'package:jollibee_kiosk/core/viewmodels/entry_model.dart';
import 'package:jollibee_kiosk/core/viewmodels/base_model.dart';

import 'package:jollibee_kiosk/ui/shared/theme.dart';
import 'package:jollibee_kiosk/ui/shared/size_config.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';
import 'package:jollibee_kiosk/ui/shared/loader/color_loader_3.dart';
import 'package:jollibee_kiosk/ui/views/base_view.dart';

class EntryView extends StatefulWidget {
  @override
  _EntryViewState createState() => _EntryViewState();
}

class _EntryViewState extends State<EntryView> {

  EntryModel _model;

  @override
  Widget build(BuildContext context) {
    return BaseView<EntryModel>(
      onModelReady: (model) {
        _model = model;
        _model.getAllMenu(context);
      },
      builder: (context, model, child) {
        return Scaffold(body: _buildBody());
      }
    );
  }

  Widget _buildBody() {
    Size size = MediaQuery.of(context).size;
    return Container(
      // color: kCoreBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.5,
              height: size.width * 0.5,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/jollibee_logo.png'),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 64),
              child: _buildContentState()
            )
          ],
        )
      )
    );
  }

  Widget _buildContentState() {
    Widget widget = Container();
    int menuLength = Provider.of<List<Menu>>(context).length;

    if (_model.state == ViewState.Idle) {
      if (menuLength > 0) widget = _buildReadyState();
      else widget = _buildFailedState();
    } else if (_model.state == ViewState.Busy) {
      widget = _buildFetchingState();
    }

    return widget;
  }

  Widget _buildReadyState() {
    double size = SizeConfig.blockSizeHorizontal * 30;
    return SizedBox(
      width: size,
      height: size,
      child: CustomBouncingContainer(
        // onTap: () => _model.getAllMenu(context), //DEBUG PURPOSES
        onTap: () => Navigator.pushNamed(context, '/home'),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Touch to Start', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: kTitleTextSize
                )
              ),
            )
          )
        )
      ),
    );
  }

  Widget _buildFailedState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text("No menu's available", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: kTitleTextSize * 0.6)
        ),
        SizedBox(height: 24),
        CustomBouncingContainer(
          onTap: () => locator<EntryModel>().getAllMenu(context),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Text('Retry', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: kTitleTextSize
                  )
                ),
              )
            )
          )
        )
      ],
    );
  }

  Widget _buildFetchingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
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
        SizedBox(height: 12.0),
        Text('Initializing', style: TextStyle(
          fontSize: kTitleTextSize
        ))
      ],
    );
  }
}