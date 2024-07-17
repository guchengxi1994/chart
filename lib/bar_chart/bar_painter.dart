import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final double indicatorSize;
  final double width;
  final double height;
  final double left;

  BarPainter(
      {required this.indicatorSize,
      required this.width,
      required this.height,
      required this.left});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    canvas.drawLine(
        Offset(left, 0), Offset(left, height - indicatorSize), paint);
  }

  @override
  bool shouldRepaint(BarPainter oldDelegate) {
    return this != oldDelegate;
  }
}
