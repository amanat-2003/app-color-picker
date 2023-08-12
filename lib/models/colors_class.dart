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

  Map<Color, ColorType> get darkColorMap {
    return {
      darkColorScheme.surfaceTint: ColorType.surfaceTint,
      darkColorScheme.scrim: ColorType.scrim,
      darkColorScheme.shadow: ColorType.shadow,
      darkColorScheme.inversePrimary: ColorType.inversePrimary,
      darkColorScheme.onInverseSurface: ColorType.onInverseSurface,
      darkColorScheme.inverseSurface: ColorType.inverseSurface,
      darkColorScheme.onSurfaceVariant: ColorType.onSurfaceVariant,
      darkColorScheme.surfaceVariant: ColorType.surfaceVariant,
      darkColorScheme.onSurface: ColorType.onSurface,
      darkColorScheme.surface: ColorType.surface,
      darkColorScheme.onBackground: ColorType.onBackground,
      darkColorScheme.background: ColorType.background,
      darkColorScheme.outlineVariant: ColorType.outlineVariant,
      darkColorScheme.outline: ColorType.outline,
      darkColorScheme.onErrorContainer: ColorType.onErrorContainer,
      darkColorScheme.errorContainer: ColorType.errorContainer,
      darkColorScheme.onError: ColorType.onError,
      darkColorScheme.error: ColorType.error,
      darkColorScheme.onTertiaryContainer: ColorType.onTertiaryContainer,
      darkColorScheme.tertiaryContainer: ColorType.tertiaryContainer,
      darkColorScheme.onTertiary: ColorType.onTertiary,
      darkColorScheme.tertiary: ColorType.tertiary,
      darkColorScheme.onSecondaryContainer: ColorType.onSecondaryContainer,
      darkColorScheme.secondaryContainer: ColorType.secondaryContainer,
      darkColorScheme.onSecondary: ColorType.onSecondary,
      darkColorScheme.secondary: ColorType.secondary,
      darkColorScheme.onPrimaryContainer: ColorType.onPrimaryContainer,
      darkColorScheme.primaryContainer: ColorType.primaryContainer,
      darkColorScheme.onPrimary: ColorType.onPrimary,
      darkColorScheme.primary: ColorType.primary,
    };
  }

  List<Color> get darkColorList {
    return darkColorMap.keys.toList();
  }

  List<ColorType> get darkColorTypeList {
    return darkColorMap.values.toList();
  }

  ColorScheme get lightColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    );
  }

  Map<Color, ColorType> get lightColorMap {
    return {
      lightColorScheme.surfaceTint: ColorType.surfaceTint,
      lightColorScheme.scrim: ColorType.scrim,
      lightColorScheme.shadow: ColorType.shadow,
      lightColorScheme.inversePrimary: ColorType.inversePrimary,
      lightColorScheme.onInverseSurface: ColorType.onInverseSurface,
      lightColorScheme.inverseSurface: ColorType.inverseSurface,
      lightColorScheme.onSurfaceVariant: ColorType.onSurfaceVariant,
      lightColorScheme.surfaceVariant: ColorType.surfaceVariant,
      lightColorScheme.onSurface: ColorType.onSurface,
      lightColorScheme.surface: ColorType.surface,
      lightColorScheme.onBackground: ColorType.onBackground,
      lightColorScheme.background: ColorType.background,
      lightColorScheme.outlineVariant: ColorType.outlineVariant,
      lightColorScheme.outline: ColorType.outline,
      lightColorScheme.onErrorContainer: ColorType.onErrorContainer,
      lightColorScheme.errorContainer: ColorType.errorContainer,
      lightColorScheme.onError: ColorType.onError,
      lightColorScheme.error: ColorType.error,
      lightColorScheme.onTertiaryContainer: ColorType.onTertiaryContainer,
      lightColorScheme.tertiaryContainer: ColorType.tertiaryContainer,
      lightColorScheme.onTertiary: ColorType.onTertiary,
      lightColorScheme.tertiary: ColorType.tertiary,
      lightColorScheme.onSecondaryContainer: ColorType.onSecondaryContainer,
      lightColorScheme.secondaryContainer: ColorType.secondaryContainer,
      lightColorScheme.onSecondary: ColorType.onSecondary,
      lightColorScheme.secondary: ColorType.secondary,
      lightColorScheme.onPrimaryContainer: ColorType.onPrimaryContainer,
      lightColorScheme.primaryContainer: ColorType.primaryContainer,
      lightColorScheme.onPrimary: ColorType.onPrimary,
      lightColorScheme.primary: ColorType.primary,
    };
  }

  List<Color> get lightColorList {
    return lightColorMap.keys.toList();
  }

  List<ColorType> get lightColorTypeList {
    return lightColorMap.values.toList();
  }

  ColorClass(this.seedColor);
}
