import 'package:chart/bar_chart/config.dart';
import 'package:chart/chart.dart';
import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final double indicatorSize;
  final double width;
  final double height;
  final double left;
  final BarChartInfomation? info;
  final double currentPosition;
  final BarConfig barConfig;

  BarPainter(
      {required this.indicatorSize,
      required this.width,
      required this.height,
      required this.left,
      required this.info,
      required this.currentPosition,
      required this.barConfig});

  @override
  void paint(Canvas canvas, Size size) {
    if (info != null && info!.guideLineHeight.isNotEmpty) {
      var guideLinePainter = Paint()
        ..color = barConfig.guideLineColor
        ..strokeWidth = barConfig.guideLineWidth;

      for (int i = 0; i < info!.guideLineHeight.length; i++) {
        canvas.drawLine(Offset(0, info!.guideLineHeight[i]),
            Offset(width, info!.guideLineHeight[i]), guideLinePainter);

        TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          text: info!.guideLines[i].toString(),
        );
        TextPainter textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.right,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(minWidth: 40, maxWidth: 40);
        textPainter.paint(canvas, Offset(width - 40, info!.guideLineHeight[i]));
      }
    }

    if (info != null && info!.info.isNotEmpty) {
      var paint2 = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;

      final Paint borderPaint = Paint()
        ..color = const Color.fromARGB(255, 8, 137, 243) // 边框颜色
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0; // 边框宽度

      for (final i in info!.info) {
        TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          text: i.label,
        );

        TextPainter textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        bool isInside =
            i.barX + i.barWidth > currentPosition && i.barX < currentPosition;

        if (isInside) {
          canvas.drawRect(
            Rect.fromLTWH(
              i.barX - 1, // 偏移以考虑边框宽度
              height - 2 * indicatorSize - i.barHeight - 1,
              i.barWidth + 2, // 扩展以考虑边框宽度
              i.barHeight + 2,
            ),
            borderPaint,
          );
        }

        textPainter.layout(minWidth: i.barWidth, maxWidth: i.barWidth);

        textPainter.paint(
            canvas,
            Offset(
                i.barX,
                isInside
                    ? height - 1.9 * indicatorSize
                    : height - 1.5 * indicatorSize));
        canvas.drawRect(
            Rect.fromLTWH(i.barX, height - 2 * indicatorSize - i.barHeight,
                i.barWidth, i.barHeight),
            paint2);
      }
    }

    final Paint paint = Paint()
      ..strokeWidth = 2.0
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(0),
          Colors.blue,
          Colors.blue,
          Colors.blue.withOpacity(0),
        ],
        stops: const [0.0, 0.3, 0.5, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromPoints(
          Offset(left, 0), Offset(left, height - indicatorSize)));

    canvas.drawLine(
        Offset(left, 0), Offset(left, height - indicatorSize), paint);
  }

  @override
  bool shouldRepaint(BarPainter oldDelegate) {
    return this != oldDelegate;
  }
}
