class Dataset {
  final List<DatasetData> data;

  Dataset({required this.data});
}

class DatasetData {
  final String label;
  final double value;

  DatasetData({required this.label, required this.value});
}
