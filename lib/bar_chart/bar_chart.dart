import 'package:chart/bar_chart/board.dart';
import 'package:chart/bar_chart/config.dart';
import 'package:chart/dataset/base_dataset.dart';
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart({
    super.key,
    required this.dataset,
    this.height = 300,
    this.width = 300,
    this.config = const BarConfig(),
  });
  final Dataset dataset;
  final double width;
  final double height;
  final BarConfig config;

  @override
  Widget build(BuildContext context) {
    return Board(
      height: height,
      width: width,
      barConfig: config,
      info:
          dataset.data.getBarChartInfomation(coordinate: width, value: height),
    );
  }
}
