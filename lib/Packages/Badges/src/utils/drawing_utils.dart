import 'package:attendance/Packages/Badges/src/badge_gradient.dart';
import 'package:attendance/Packages/Badges/src/badge_shape.dart';
import 'package:attendance/Packages/Badges/src/painters/instagram_badge_shape_painter.dart';
import 'package:attendance/Packages/Badges/src/painters/twitter_badge_shape_painter.dart';
import 'package:flutter/material.dart';

class DrawingUtils {
  static CustomPainter? drawBadgeShape({
    required BadgeShape shape,
    Color? color,
    BadgeGradient? badgeGradient,
    BadgeGradient? borderGradient,
    BorderSide? borderSide,
  }) {
    switch (shape) {
      case BadgeShape.twitter:
        return TwitterBadgeShapePainter(
          color: color,
          badgeGradient: badgeGradient,
          borderSide: borderSide,
          borderGradient: borderGradient,
        );
      case BadgeShape.instagram:
        return InstagramBadgeShapePainter(
          color: color,
          badgeGradient: badgeGradient,
          borderSide: borderSide,
          borderGradient: borderGradient,
        );
      case BadgeShape.square:
      case BadgeShape.circle:
        break;
    }
    return null;
  }
}
