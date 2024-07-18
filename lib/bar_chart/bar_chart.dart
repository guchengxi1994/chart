import 'package:chart/bar_chart/background.dart';
import 'package:chart/bar_chart/enums.dart';
import 'package:chart/dataset/base_dataset.dart';
import 'package:flutter/material.dart';

class BarChart extends StatefulWidget {
  const BarChart(
      {super.key,
      required this.dataset,
      this.height = 300,
      this.width = 300,
      this.barChartDirection = BarChartDirection.vertical});
  final Dataset dataset;
  final double width;
  final double height;

  /// TODO unimplemented
  final BarChartDirection barChartDirection;

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late List<BarInfo> info = [];

  @override
  void initState() {
    super.initState();
    info = widget.dataset.data
        .getBarPositions(coordinate: widget.width, value: widget.height);
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      height: widget.height,
      width: widget.width,
      info: info,
    );
  }
}
