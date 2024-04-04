import 'package:flutter/material.dart';

class StartImageClipPath extends ShapeBorder {
  final double radius;

  const StartImageClipPath(this.radius);

  Path getClip(Offset offset, Size size) {
    final path = Path();
    path.moveTo(offset.dx, offset.dy);
    path.relativeMoveTo(0, size.height - radius);
    path.relativeArcToPoint(Offset(radius, radius),
        radius: Radius.circular(radius), rotation: 90, clockwise: false);
    path.relativeLineTo(size.width - 2 * radius, -size.height * 0.05);
    path.relativeArcToPoint(Offset(radius, -radius),
        radius: Radius.circular(radius), rotation: 90, clockwise: false);
    path.relativeLineTo(0, -size.height * 0.95 + 2 * radius);
    path.relativeArcToPoint(Offset(-radius, -radius),
        radius: Radius.circular(radius), rotation: 90, clockwise: false);
    path.relativeLineTo(-size.width + 2 * radius, 0);
    path.relativeArcToPoint(Offset(-radius, radius),
        radius: Radius.circular(radius), rotation: 90, clockwise: false);
    path.relativeLineTo(0, size.height - 2 * radius);
    path.close();
    return path;
  }

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getClip(rect.topLeft, rect.size);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      getClip(rect.topLeft, rect.size);

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
