import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'color_loader_4.dart';

class ModalLoaderDialog extends StatelessWidget {
  final bool inAsyncCall;
  final String message;
  final Color color;
  final bool dismissible;
  final Widget child;

  ModalLoaderDialog({
    Key key,
    @required this.inAsyncCall,
    this.message,
    this.color = Colors.black54,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(this.child);
    Widget layOutProgressIndicator = Center(child: ModalLoader(message: this.message));

    final modal = [
      IgnorePointer(
        ignoring: !this.inAsyncCall,
        child: AnimatedOpacity(
          opacity: this.inAsyncCall ? 1 : 0,
          duration: Duration(milliseconds: 200),
          child: ModalBarrier(dismissible: this.dismissible, color: this.color)
        ),
      ),
      IgnorePointer(
        ignoring: !this.inAsyncCall,
        child: AnimatedOpacity(
          opacity: this.inAsyncCall ? 1 : 0,
          duration: Duration(milliseconds: 200),
          child: layOutProgressIndicator
        )
      ),
      // AbsorbPointer(
      //   absorbing: this.inAsyncCall,
      //   child: AnimatedOpacity(
      //     opacity: this.inAsyncCall ? 1 : 0,
      //     duration: Duration(milliseconds: 200),
      //     child: layOutProgressIndicator
      //     // child: Visibility(
      //     //   visible: this.inAsyncCall,
      //     //   child: layOutProgressIndicator,
      //     // )
      //   ),
      // ),
    ];
    widgetList += modal;

    return Stack(
      children: widgetList,
    );
  }
}

class ModalLoader extends StatelessWidget {
  ModalLoader({this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: 200
      ),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: Container(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ColorLoader4(),
              _buildMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    if (this.message == null) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Text(this.message, textAlign: TextAlign.center)
    );
  }
}