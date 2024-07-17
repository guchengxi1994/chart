import 'package:chart/bar_chart/enums.dart';
import 'package:flutter/material.dart';

import 'animated_background.dart';
import 'bar_painter.dart';

class Background extends StatefulWidget {
  const Background(
      {super.key,
      this.height = 300,
      this.width = 300,
      this.decoration =
          const BoxDecoration(color: Color.fromARGB(255, 224, 137, 240)),
      this.indicatorSize = 30})
      : assert(width > indicatorSize &&
            height > indicatorSize &&
            indicatorSize > 20);
  final double width;
  final double height;
  final BoxDecoration decoration;
  final double indicatorSize;

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with TickerProviderStateMixin {
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
                    indicatorSize: widget.indicatorSize,
                    reclip: _animation,
                    direction: BarChartDirection.vertical),
                child: Container(
                  decoration: widget.decoration,
                  width: widget.width,
                  height: widget.height,
                  child: CustomPaint(
                    painter: BarPainter(
                      width: widget.width,
                      height: widget.height,
                      indicatorSize: widget.indicatorSize,
                      left: valueNotifier.value + widget.indicatorSize / 2,
                    ),
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
                          widget.width - widget.indicatorSize &&
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
                    borderRadius:
                        BorderRadius.circular(widget.indicatorSize - 5),
                    border: Border.all(color: Colors.grey[300]!, width: 0.5),
                  ),
                  width: widget.indicatorSize - 5,
                  height: widget.indicatorSize - 5,
                )))
      ],
    );
  }
}
