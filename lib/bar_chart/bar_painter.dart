import 'package:simple_interactive_chart/simple_interactive_chart.dart';
import 'package:flutter/material.dart';

class BarPainter extends CustomPainter {
  final double indicatorSize;
  final double width;
  final double height;
  final double offset;
  final BarChartInfomation? info;
  final double currentPosition;
  final BarConfig barConfig;

  BarPainter(
      {required this.indicatorSize,
      required this.width,
      required this.height,
      required this.offset,
      required this.info,
      required this.currentPosition,
      required this.barConfig});

  @override
  void paint(Canvas canvas, Size size) {
    if (barConfig.barChartDirection == BarChartDirection.vertical) {
      verticalPaint(canvas, size);
    } else {
      horizontalPaint(canvas, size);
    }
  }

  @override
  bool shouldRepaint(BarPainter oldDelegate) {
    return this != oldDelegate;
  }

  verticalPaint(Canvas canvas, Size size) {
    if (info != null &&
        info!.guideLineValues.isNotEmpty &&
        barConfig.showGuideLine) {
      var guideLinePainter = Paint()
        ..color = barConfig.guideLineColor
        ..strokeWidth = barConfig.guideLineWidth;

      for (int i = 0; i < info!.guideLineValues.length; i++) {
        canvas.drawLine(Offset(0, info!.guideLineValues[i]),
            Offset(width, info!.guideLineValues[i]), guideLinePainter);

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
        textPainter.paint(canvas, Offset(width - 40, info!.guideLineValues[i]));
      }
    }

    if (info != null && info!.info.isNotEmpty) {
      var barPaint = Paint()
        ..color = barConfig.barColor
        ..style = PaintingStyle.fill;

      var barPaintLighter = Paint()
        ..color = barConfig.barColor.withAlpha(128)
        ..style = PaintingStyle.fill;

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

        if (isInside && barConfig.highlightType == HighlightType.border) {
          final Paint borderPaint = Paint()
            ..color = const Color.fromARGB(255, 8, 137, 243) // 边框颜色
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0; // 边框宽度

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
            barConfig.highlightType == HighlightType.lighter && isInside
                ? barPaintLighter
                : barPaint);
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
          Offset(offset, 0), Offset(offset, height - indicatorSize)));

    canvas.drawLine(
        Offset(offset, 0), Offset(offset, height - indicatorSize), paint);
  }

  horizontalPaint(Canvas canvas, Size size) {
    final double paddingLeft = 20;

    if (info != null &&
        info!.guideLineValues.isNotEmpty &&
        barConfig.showGuideLine) {
      var guideLinePainter = Paint()
        ..color = barConfig.guideLineColor
        ..strokeWidth = barConfig.guideLineWidth;

      for (int i = 0; i < info!.guideLineValues.length; i++) {
        canvas.drawLine(
            Offset(
                width +
                    paddingLeft -
                    2 * indicatorSize -
                    info!.guideLineValues[i],
                0),
            Offset(
                width +
                    paddingLeft -
                    2 * indicatorSize -
                    info!.guideLineValues[i],
                height),
            guideLinePainter);

        TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          text: info!.guideLines[i].toString(),
        );
        TextPainter textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(minWidth: 40, maxWidth: 40);
        textPainter.paint(
            canvas,
            Offset(
                width +
                    paddingLeft -
                    2 * indicatorSize -
                    info!.guideLineValues[i],
                height - 20));
      }
    }

    if (info != null && info!.info.isNotEmpty) {
      var barPaint = Paint()
        ..color = barConfig.barColor
        ..style = PaintingStyle.fill;

      var barPaintLighter = Paint()
        ..color = barConfig.barColor.withAlpha(128)
        ..style = PaintingStyle.fill;

      for (final i in info!.info) {
        TextSpan span = TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 12),
          text: i.label,
        );

        TextPainter textPainter = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
        );

        bool isInside =
            i.barX + i.barWidth > currentPosition && i.barX < currentPosition;

        if (isInside && barConfig.highlightType == HighlightType.border) {
          final Paint borderPaint = Paint()
            ..color = const Color.fromARGB(255, 8, 137, 243) // 边框颜色
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.0; // 边框宽度

          canvas.drawRect(
            Rect.fromLTWH(
                paddingLeft, i.barX - 1, i.barHeight + 2, i.barWidth + 2),
            borderPaint,
          );
        }

        textPainter.layout(minWidth: i.barWidth, maxWidth: i.barWidth);

        textPainter.paint(canvas, Offset(0, i.barX));

        canvas.drawRect(
            Rect.fromLTWH(paddingLeft, i.barX, i.barHeight, i.barWidth),
            barConfig.highlightType == HighlightType.lighter && isInside
                ? barPaintLighter
                : barPaint);
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
      ).createShader(Rect.fromPoints(
          Offset(paddingLeft, offset), Offset(width - indicatorSize, offset)));

    canvas.drawLine(Offset(paddingLeft, offset),
        Offset(width - indicatorSize, offset), paint);
  }
}
