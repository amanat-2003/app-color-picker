// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_color_picker/models/color_types.dart';

class ColorObj {
  final Color color;
  final ColorType colorType;
  final String colorName;
  ColorObj({
    required this.color,
    required this.colorType,
    required this.colorName,
  });

  @override
  bool operator ==(covariant ColorObj other) {
    if (identical(this, other)) return true;

    return other.color.value == color.value;
  }

  @override
  int get hashCode => color.value.hashCode;

  ColorObj copyWith({
    Color? color,
    ColorType? colorType,
    String? colorName,
  }) {
    return ColorObj(
      color: color ?? this.color,
      colorType: colorType ?? this.colorType,
      colorName: colorName ?? this.colorName,
    );
  }

  @override
  String toString() => 'ColorObj(color: $color, colorType: $colorType, colorName: $colorName)';
}
