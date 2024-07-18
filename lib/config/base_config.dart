import 'package:flutter/material.dart';

enum HighlightType { lighter, darker, border }

class BaseConfig {
  final HighlightType highlightType;
  final Color backgroundColor;

  const BaseConfig({
    this.highlightType = HighlightType.border,
    this.backgroundColor = Colors.white,
  });
}