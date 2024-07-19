import 'package:chart/bar_chart/enums.dart';
import 'package:chart/config/base_config.dart';
import 'package:flutter/material.dart';

class BarConfig extends BaseConfig {
  final Color barColor;

  final bool showLabel;

  final bool showLine;
  final Color lineColor;

  final bool showIndicator;
  final double indicatorSize;

  /// guide line
  final bool showGuideLine;
  final Color guideLineColor;
  final double guideLineWidth;

  /// TODO unimplemented
  final BarChartDirection barChartDirection;

  const BarConfig(
      {this.barColor = Colors.red,
      this.lineColor = Colors.blue,
      this.showIndicator = true,
      this.showGuideLine = true,
      this.showLabel = true,
      this.showLine = true,
      this.indicatorSize = 30,
      this.barChartDirection = BarChartDirection.vertical,
      this.guideLineColor = Colors.grey,
      this.guideLineWidth = 1,
      super.backgroundColor,
      super.highlightType})
      : super();
}
