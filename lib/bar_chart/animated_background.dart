import 'package:chart/bar_chart/enums.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends CustomClipper<Path> {
  AnimatedBackground(
      {this.indicatorSize = 30, required this.reclip, required this.direction})
      : super(reclip: reclip);

  final double indicatorSize;
  final Animation<double> reclip;
  final BarChartDirection direction;

  @override
  getClip(Size size) {
    var path = Path();

    if (direction == BarChartDirection.horizontal) {
      /// TODO unimplemented
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, reclip.value);
      final (p2x, p2y) = (size.width, reclip.value + indicatorSize);
      final (p1x, p1y) = (
        size.width - indicatorSize,
        (reclip.value + indicatorSize + reclip.value) / 2
      );
      path.quadraticBezierTo(p1x, p1y, p2x, p2y);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(reclip.value, size.height);

      final (p1x, p1y) = (
        (reclip.value + indicatorSize + reclip.value) / 2,
        size.height - indicatorSize
      );

      final (p2x, p2y) = (reclip.value + indicatorSize, size.height);

      path.quadraticBezierTo(p1x, p1y, p2x * 1.0, p2y);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    return path;
  }

  @override
  bool shouldReclip(covariant AnimatedBackground oldClipper) {
    return oldClipper != this;
  }
}
