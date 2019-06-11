import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';
import 'package:jollibee_kiosk/ui/shared/custom_ui.dart';

import 'package:jollibee_kiosk/ui/shared/theme.dart';

class UIHelper {
  static showNiceToast(BuildContext context, {
    String title, 
    String subTitle,
    VoidCallback onTab,
    Widget icon = const Icon(EvaIcons.alertTriangle, color: Colors.white),
    AnimationTypeAchievement typeAnimationContent =  AnimationTypeAchievement.fadeSlideToUp,
    double borderRadius = 12.0,
    Color color = kRed,
    TextStyle textStyleTitle,
    TextStyle textStyleSubTitle,
    AlignmentGeometry alignment = Alignment.center,
    Duration duration = const Duration(seconds: 3),
    bool isCircle = false
  }) {
    return AchievementView(
      context,
      title: title,
      subTitle: subTitle,
      onTab: onTab,
      icon: icon,
      typeAnimationContent: typeAnimationContent,
      borderRadius: borderRadius,
      color: color,
      // textStyleTitle: TextStyle(fontSize: kActionButtonTextSize).merge(textStyleTitle),
      // textStyleSubTitle: TextStyle(fontSize: kBodyTextSize).merge(textStyleSubTitle),
      alignment: alignment,
      duration: duration,
      isCircle: isCircle,
    )..show();
  }

  void showConfirmDialog({
    @required BuildContext context, 
    String title, 
    String message, 
    String cancelText,
    String confirmText,
    Color cancelColor = kRed,
    Color confirmColor = kGreen,
    // TextStyle cancelStyle,
    // TextStyle confirmStyle,
    VoidCallback onCancel,
    @required VoidCallback onConfirm
  }) {

    // TextStyle _defaultStyle = TextStyle(
    //   color: Theme.of(context).primaryColor,
    //   fontSize: kActionButtonTextSize
    // );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title, style: TextStyle(
            fontSize: kSubheadTextSize
          )) : Container(),
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: message != null ? Container(
              padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 12.0),
              child: Text(message, style: TextStyle(
                fontSize: kBodyTextSize
              ))
            ) : Container(height: 0),
          ),
          actions: <Widget>[
            _buildActionButtonItem(context, 
              text: cancelText ?? 'CANCEL', 
              color: cancelColor,
              onTap: onCancel
            ),
            _buildActionButtonItem(context, 
              text: confirmText ?? 'OK', 
              color: confirmColor,
              onTap: onConfirm
            )
            // FlatButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //     if (onCancel != null) onCancel();
            //   },
            //   child: Text(cancelText ?? 'CANCEL', style: _defaultStyle.merge(cancelStyle)),
            // ),
            // FlatButton(
            //   highlightColor: confirmStyle?.color?.withOpacity(0.2),
            //   onPressed: () {
            //     Navigator.pop(context);
            //     onConfirm();
            //   },
            //   child: Text(confirmText ?? 'OK', style: _defaultStyle.merge(confirmStyle)),
            // )
          ],
        );
      }
    );
  }


  // TODO
  Widget _buildActionButtonItem(BuildContext context, {@required String text, VoidCallback onTap, Color color = kRed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: CustomBouncingContainer(
        onTap: onTap == null ? () => Navigator.pop(context) : onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: color,
          ),
          padding: const EdgeInsets.all(18.0),
          child: Text(text, 
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: kBodyTextSize
            )
          )
        )
      ),
    );
  }
}