import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:achievement_view/achievement_view.dart';
import 'package:achievement_view/achievement_widget.dart';

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
}