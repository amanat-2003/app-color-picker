import 'package:app_color_picker/extensions/string/remove_all.dart';
import 'package:flutter/material.dart' show Color;


extension AsHtmlColorToColor on String {
  Color htmlColorToColor() => Color(
        int.parse(
          removeAll(['0x', '#']).padLeft(8, 'ff'),
          radix:16,
        ),
      );
}
