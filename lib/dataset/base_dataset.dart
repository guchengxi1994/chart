import 'dart:math' as math;

class Dataset<S extends DatasetData> {
  final List<S> data;

  Dataset({required this.data});
}

class DatasetData {
  final String label;
  final double value;
  final int index;

  DatasetData({required this.label, this.value = 0, required this.index});
}

Set<double> divideNumber(double number) {
  Set<double> results = {};
  double step = number / 100;

  for (int i = 1; i < step; i++) {
    double value = i * 100;
    if (value < number) {
      results.add(value);
    }
  }

  return results;
}

extension DataExtension<S extends DatasetData> on List<S> {
  List<double> getGuideLines() {
    if (isEmpty) {
      return [];
    }

    double max = reduce((c, n) => c.value > n.value ? c : n).value;

    if (max <= 100) {
      return [0, 100];
    }

    List dividers = (divideNumber(max)..add(max)).toList();

    return [0, ...dividers];
  }

  BarChartInfomation? getBarChartInfomation(
      {double coordinate = 300,
      double value = 300,
      double indicatorSize = 30}) {
    if (isEmpty) {
      return null;
    }

    double max = reduce((c, n) => c.value > n.value ? c : n).value;

    List<double> guideLines = getGuideLines();

    // print("getGuideLines  $guideLines");

    final List<double> guideLineHeight = guideLines.map((e) {
      return (value - 2 * indicatorSize) -
          e / max * (value - 2 * indicatorSize);
    }).toList();

    // print("getGuideLines  $guideLineHeight");

    max = math.max(max, guideLines.last);

    final result = <BarInfo>[];
    const double totalSpacingRatio = 1.5;
    double r = totalSpacingRatio * length;

    final double barWidth = (coordinate - /* padding */ 40) / r;
    final double barSpacing = barWidth / 2;

    double xOffset = /* padding */ barSpacing / 2 + 20;

    for (int i = 0; i < length; i++) {
      double x = xOffset;
      double y = this[i].value / max * (value - 2 * indicatorSize);
      result.add(BarInfo(
          label: this[i].label,
          index: this[i].index,
          barHeight: y,
          barWidth: barWidth,
          barX: x));
      xOffset += barWidth + barSpacing;
    }

    return BarChartInfomation(
        guideLineHeight: guideLineHeight, info: result, guideLines: guideLines);
  }
}

class BarChartInfomation {
  final List<BarInfo> info;
  final List<double> guideLines;
  final List<double> guideLineHeight;

  BarChartInfomation(
      {required this.guideLineHeight,
      required this.guideLines,
      required this.info});
}

class BarInfo extends DatasetData {
  final double barWidth;
  final double barHeight;
  final double barX;

  BarInfo(
      {required super.label,
      required super.index,
      required this.barHeight,
      required this.barWidth,
      required this.barX});
}
