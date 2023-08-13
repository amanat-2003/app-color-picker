import 'package:app_color_picker/models/color_types.dart';
import 'package:flutter/material.dart';

class ColorClass {
  final Color seedColor;

  ColorScheme get darkColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );
  }

  Map<ColorType, Color> get darkColorMap {
    return {
      ColorType.primary: darkColorScheme.primary,
      ColorType.onPrimary: darkColorScheme.onPrimary,
      ColorType.primaryContainer: darkColorScheme.primaryContainer,
      ColorType.onPrimaryContainer: darkColorScheme.onPrimaryContainer,
      ColorType.secondary: darkColorScheme.secondary,
      ColorType.onSecondary: darkColorScheme.onSecondary,
      ColorType.secondaryContainer: darkColorScheme.secondaryContainer,
      ColorType.onSecondaryContainer: darkColorScheme.onSecondaryContainer,
      ColorType.tertiary: darkColorScheme.tertiary,
      ColorType.onTertiary: darkColorScheme.onTertiary,
      ColorType.tertiaryContainer: darkColorScheme.tertiaryContainer,
      ColorType.onTertiaryContainer: darkColorScheme.onTertiaryContainer,
      ColorType.error: darkColorScheme.error,
      ColorType.onError: darkColorScheme.onError,
      ColorType.errorContainer: darkColorScheme.errorContainer,
      ColorType.onErrorContainer: darkColorScheme.onErrorContainer,
      ColorType.outline: darkColorScheme.outline,
      ColorType.outlineVariant: darkColorScheme.outlineVariant,
      ColorType.background: darkColorScheme.background,
      ColorType.onBackground: darkColorScheme.onBackground,
      ColorType.surface: darkColorScheme.surface,
      ColorType.onSurface: darkColorScheme.onSurface,
      ColorType.surfaceVariant: darkColorScheme.surfaceVariant,
      ColorType.onSurfaceVariant: darkColorScheme.onSurfaceVariant,
      ColorType.inverseSurface: darkColorScheme.inverseSurface,
      ColorType.onInverseSurface: darkColorScheme.onInverseSurface,
      ColorType.inversePrimary: darkColorScheme.inversePrimary,
      ColorType.shadow: darkColorScheme.shadow,
      ColorType.scrim: darkColorScheme.scrim,
      ColorType.surfaceTint: darkColorScheme.surfaceTint,
    };
  }

  List<Color> get darkColorList {
    return darkColorMap.values.toList();
  }

  List<ColorType> get darkColorTypeList {
    return darkColorMap.keys.toList();
  }

  ColorScheme get lightColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
  }

  Map<ColorType, Color> get lightColorMap {
    return {
      ColorType.primary: lightColorScheme.primary,
      ColorType.onPrimary: lightColorScheme.onPrimary,
      ColorType.primaryContainer: lightColorScheme.primaryContainer,
      ColorType.onPrimaryContainer: lightColorScheme.onPrimaryContainer,
      ColorType.secondary: lightColorScheme.secondary,
      ColorType.onSecondary: lightColorScheme.onSecondary,
      ColorType.secondaryContainer: lightColorScheme.secondaryContainer,
      ColorType.onSecondaryContainer: lightColorScheme.onSecondaryContainer,
      ColorType.tertiary: lightColorScheme.tertiary,
      ColorType.onTertiary: lightColorScheme.onTertiary,
      ColorType.tertiaryContainer: lightColorScheme.tertiaryContainer,
      ColorType.onTertiaryContainer: lightColorScheme.onTertiaryContainer,
      ColorType.error: lightColorScheme.error,
      ColorType.onError: lightColorScheme.onError,
      ColorType.errorContainer: lightColorScheme.errorContainer,
      ColorType.onErrorContainer: lightColorScheme.onErrorContainer,
      ColorType.outline: lightColorScheme.outline,
      ColorType.outlineVariant: lightColorScheme.outlineVariant,
      ColorType.background: lightColorScheme.background,
      ColorType.onBackground: lightColorScheme.onBackground,
      ColorType.surface: lightColorScheme.surface,
      ColorType.onSurface: lightColorScheme.onSurface,
      ColorType.surfaceVariant: lightColorScheme.surfaceVariant,
      ColorType.onSurfaceVariant: lightColorScheme.onSurfaceVariant,
      ColorType.inverseSurface: lightColorScheme.inverseSurface,
      ColorType.onInverseSurface: lightColorScheme.onInverseSurface,
      ColorType.inversePrimary: lightColorScheme.inversePrimary,
      ColorType.shadow: lightColorScheme.shadow,
      ColorType.scrim: lightColorScheme.scrim,
      ColorType.surfaceTint: lightColorScheme.surfaceTint,
    };
  }

  List<Color> get lightColorList {
    return lightColorMap.values.toList();
  }

  List<ColorType> get lightColorTypeList {
    return lightColorMap.keys.toList();
  }

  ColorClass(this.seedColor);
}
