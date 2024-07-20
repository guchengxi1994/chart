import 'package:chart/chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BarChart(
              config: const BarConfig(
                  highlightType: HighlightType.border,
                  barChartDirection: BarChartDirection.horizontal),
              dataset: Dataset(data: [
                DatasetData(label: "1", index: 1, value: 100),
                DatasetData(label: "2", index: 2, value: 20),
                DatasetData(label: "3", index: 3, value: 80),
                DatasetData(label: "4", index: 4, value: 64),
                DatasetData(label: "5", index: 5, value: 13),
                DatasetData(label: "6", index: 6, value: 348),
                DatasetData(label: "7", index: 7, value: 34),
                DatasetData(label: "8", index: 8, value: 57),
                DatasetData(label: "9", index: 9, value: 13),
                DatasetData(label: "10", index: 10, value: 54),
              ]),
            ),
            const SizedBox(
              height: 100,
            ),
            BarChart(
              config: const BarConfig(highlightType: HighlightType.lighter),
              dataset: Dataset(data: [
                DatasetData(label: "1", index: 1, value: 100),
                DatasetData(label: "2", index: 2, value: 20),
                DatasetData(label: "3", index: 3, value: 80),
                DatasetData(label: "4", index: 4, value: 64),
                DatasetData(label: "5", index: 5, value: 13),
                DatasetData(label: "6", index: 6, value: 348),
                DatasetData(label: "7", index: 7, value: 34),
                DatasetData(label: "8", index: 8, value: 57),
                DatasetData(label: "9", index: 9, value: 13),
                DatasetData(label: "10", index: 10, value: 54),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
