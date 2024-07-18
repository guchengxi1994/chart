import 'package:chart/bar_chart/config.dart';
import 'package:chart/bar_chart/enums.dart';
import 'package:chart/dataset/base_dataset.dart';
import 'package:flutter/material.dart';

import 'animated_background.dart';
import 'bar_painter.dart';

class Board extends StatefulWidget {
  Board({
    super.key,
    this.height = 300,
    this.width = 300,
    required this.barConfig,
    required this.info,
  }) : assert(width > barConfig.indicatorSize &&
            height > barConfig.indicatorSize &&
            barConfig.indicatorSize > 20);
  final double width;
  final double height;
  final BarChartInfomation? info;
  final BarConfig barConfig;

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> with TickerProviderStateMixin {
  late ValueNotifier<double> valueNotifier = ValueNotifier(initial);

  late AnimationController _controller;
  late Animation<double> _animation;

  late final double initial = 20;

  late double end = initial;
  late double start = initial;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 10))
      ..reset();
    _animation = Tween<double>(begin: 0.0, end: initial).animate(_controller);

    _controller.forward();

    valueNotifier.addListener(() {
      end = valueNotifier.value;
      _animation = Tween<double>(begin: start, end: end).animate(_controller);
      _controller.reset();
      _controller.forward();

      setState(() {
        start = end;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.only(bottom: 20),
          child: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (c, i, w) {
              return ClipPath(
                clipper: AnimatedBackground(
                    indicatorSize: widget.barConfig.indicatorSize,
                    reclip: _animation,
                    direction: BarChartDirection.vertical),
                child: Container(
                  decoration:
                      BoxDecoration(color: widget.barConfig.backgroundColor),
                  width: widget.width,
                  height: widget.height,
                  child: CustomPaint(
                    painter: BarPainter(
                        currentPosition: valueNotifier.value +
                            widget.barConfig.indicatorSize / 2,
                        width: widget.width,
                        height: widget.height,
                        indicatorSize: widget.barConfig.indicatorSize,
                        left: valueNotifier.value +
                            widget.barConfig.indicatorSize / 2,
                        info: widget.info,
                        barConfig: widget.barConfig),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
            bottom: 0,
            left: valueNotifier.value + 5 / 2,
            child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (valueNotifier.value + details.delta.dx.ceil() <
                          widget.width - widget.barConfig.indicatorSize &&
                      valueNotifier.value + details.delta.dx.ceil() > 0) {
                    valueNotifier.value += details.delta.dx.ceil();
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey[100]!,
                        Colors.grey[300]!,
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        widget.barConfig.indicatorSize - 5),
                    border: Border.all(color: Colors.grey[300]!, width: 0.5),
                  ),
                  width: widget.barConfig.indicatorSize - 5,
                  height: widget.barConfig.indicatorSize - 5,
                )))
      ],
    );
  }
}
