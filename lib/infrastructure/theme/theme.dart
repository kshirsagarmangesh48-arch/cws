import "package:flutter/material.dart";

class CwsTheme {
  final TextTheme textTheme;

  const CwsTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff365e9d),
      surfaceTint: Color(0xff365e9d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff82a8ec),
      onPrimaryContainer: Color(0xff001c40),
      secondary: Color(0xff515f79),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd9e4ff),
      onSecondaryContainer: Color(0xff3c4962),
      tertiary: Color(0xff76517f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb88ec1),
      onTertiaryContainer: Color(0xff1f002a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9f9ff),
      onSurface: Color(0xff1a1c20),
      onSurfaceVariant: Color(0xff434750),
      outline: Color(0xff737781),
      outlineVariant: Color(0xffc3c6d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3035),
      inversePrimary: Color(0xffaac7ff),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3e),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff194683),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff0d1c32),
      secondaryFixedDim: Color(0xffb9c7e5),
      onSecondaryFixedVariant: Color(0xff3a4760),
      tertiaryFixed: Color(0xfffad7ff),
      onTertiaryFixed: Color(0xff2d0d38),
      tertiaryFixedDim: Color(0xffe4b7ed),
      onTertiaryFixedVariant: Color(0xff5d3966),
      surfaceDim: Color(0xffdad9df),
      surfaceBright: Color(0xfff9f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f3f9),
      surfaceContainer: Color(0xffeeedf3),
      surfaceContainerHigh: Color(0xfffaf7f7),
      surfaceContainerHighest: Color(0xffe2e2e8),
    );
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaac7ff),
      surfaceTint: Color(0xffaac7ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff6e94d6),
      onPrimaryContainer: Color(0xff343232),
      secondary: Color(0xffb9c7e5),
      onSecondary: Color(0xff233148),
      secondaryContainer: Color(0xff323f58),
      onSecondaryContainer: Color(0xffc6d4f3),
      tertiary: Color(0xffe4b7ed),
      onTertiary: Color(0xff44234e),
      tertiaryContainer: Color(0xff8e6797),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff121317),
      onSurface: Color(0xffe2e2e8),
      onSurfaceVariant: Color(0xffc3c6d2),
      outline: Color(0xff8d909b),
      outlineVariant: Color(0xff434750),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe2e2e8),
      inversePrimary: Color(0xff365e9d),
      primaryFixed: Color(0xffd6e3ff),
      onPrimaryFixed: Color(0xff001b3e),
      primaryFixedDim: Color(0xffaac7ff),
      onPrimaryFixedVariant: Color(0xff194683),
      secondaryFixed: Color(0xffd6e3ff),
      onSecondaryFixed: Color(0xff0d1c32),
      secondaryFixedDim: Color(0xffb9c7e5),
      onSecondaryFixedVariant: Color(0xff3a4760),
      tertiaryFixed: Color(0xfffad7ff),
      onTertiaryFixed: Color(0xff2d0d38),
      tertiaryFixedDim: Color(0xffe4b7ed),
      onTertiaryFixedVariant: Color(0xff5d3966),
      surfaceDim: Color(0xff121317),
      surfaceBright: Color(0xff38393e),
      surfaceContainerLowest: Color(0xff0c0e12),
      surfaceContainerLow: Color(0xff1a1c20),
      surfaceContainer: Color(0xff1e2024),
      surfaceContainerHigh: Color(0xff282a2e),
      surfaceContainerHighest: Color(0xff333539),
    );
  }



  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
