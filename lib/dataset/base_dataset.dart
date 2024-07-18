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

extension DataExtension<S extends DatasetData> on List<S> {
  List<BarInfo> getBarPositions(
      {double coordinate = 300,
      double value = 300,
      double indicatorSize = 30}) {
    double max = reduce((c, n) => c.value > n.value ? c : n).value;

    final result = <BarInfo>[];
    const double totalSpacingRatio = 1.5;
    final double barWidth = coordinate / (length * totalSpacingRatio);
    final double barSpacing = barWidth / 2;

    double xOffset = barSpacing / 2;

    for (int i = 0; i < length; i++) {
      double x = xOffset + (barWidth / 2);
      double y = this[i].value / max * (value - 2 * indicatorSize);
      result.add(BarInfo(
          label: this[i].label,
          index: this[i].index,
          barHeight: y,
          barWidth: barWidth,
          barX: x));
      xOffset += barWidth + barSpacing;
    }

    return result;
  }
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
