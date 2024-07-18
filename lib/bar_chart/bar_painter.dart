import 'package:chart/chart.dart';
import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final double indicatorSize;
  final double width;
  final double height;
  final double left;
  final List<BarInfo> info;
  final double currentPosition;

  BarPainter(
      {required this.indicatorSize,
      required this.width,
      required this.height,
      required this.left,
      required this.info,
      required this.currentPosition});

  @override
  void paint(Canvas canvas, Size size) {
    if (info.isNotEmpty) {
      var paint2 = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;

      final Paint borderPaint = Paint()
        ..color = const Color.fromARGB(255, 8, 137, 243) // 边框颜色
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0; // 边框宽度

      for (final i in info) {
        if (i.barX + i.barWidth > currentPosition && i.barX < currentPosition) {
          canvas.drawRect(
            Rect.fromLTWH(
              i.barX - 1, // 偏移以考虑边框宽度
              height - i.barHeight - 1,
              i.barWidth + 2, // 扩展以考虑边框宽度
              i.barHeight + 2,
            ),
            borderPaint,
          );
        }
        canvas.drawRect(
            Rect.fromLTWH(
                i.barX, height - i.barHeight, i.barWidth, i.barHeight),
            paint2);
      }
    }

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
