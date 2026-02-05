import 'package:flutter/material.dart';
import 'dart:math';

class ColorUtils {
  static String toHex(Color color, {bool includeHash = true}) {
    return '${includeHash ? '#' : ''}${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  static Color? fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    if (hex.length == 8) {
      return Color(int.parse('0x$hex'));
    }
    return null;
  }

  static HSLColor toExampleHSL(Color color) {
    return HSLColor.fromColor(color);
  }

  static Map<String, String> getCMYK(Color color) {
    double r = color.red / 255;
    double g = color.green / 255;
    double b = color.blue / 255;

    double k = 1 - [r, g, b].reduce(max);
    double c = (1 - r - k) / (1 - k);
    double m = (1 - g - k) / (1 - k);
    double y = (1 - b - k) / (1 - k);

    if (k.isNaN) k = 1;
    if (c.isNaN) c = 0;
    if (m.isNaN) m = 0;
    if (y.isNaN) y = 0;

    return {
      'c': '${(c * 100).round()}%',
      'm': '${(m * 100).round()}%',
      'y': '${(y * 100).round()}%',
      'k': '${(k * 100).round()}%',
    };
  }

  static Map<String, int> getRGB(Color color) {
    return {
      'r': color.red,
      'g': color.green,
      'b': color.blue,
    };
  }

  static Map<String, String> getHSV(Color color) {
    final hsv = HSVColor.fromColor(color);
    return {
      'h': '${hsv.hue.round()}°',
      's': '${(hsv.saturation * 100).round()}%',
      'v': '${(hsv.value * 100).round()}%',
    };
  }

  static Map<String, String> getHSL(Color color) {
    final hsl = HSLColor.fromColor(color);
    return {
      'h': '${hsl.hue.round()}°',
      's': '${(hsl.saturation * 100).round()}%',
      'l': '${(hsl.lightness * 100).round()}%',
    };
  }

  // --- Parsing Methods ---

  static Color? fromRGB(String value) {
    // Expected format: "255, 0, 0"
    try {
      final parts = value.replaceAll(' ', '').split(',');
      if (parts.length != 3) return null;
      int r = int.parse(parts[0]).clamp(0, 255);
      int g = int.parse(parts[1]).clamp(0, 255);
      int b = int.parse(parts[2]).clamp(0, 255);
      return Color.fromARGB(255, r, g, b);
    } catch (_) {
      return null;
    }
  }

  static Color? fromCMYK(String value) {
    // Expected format: "0%, 100%, 100%, 0%" or "0, 1, 1, 0"
    try {
      final parts = value.replaceAll('%', '').replaceAll(' ', '').split(',');
      if (parts.length != 4) return null;
      
      double c = double.parse(parts[0]) / 100.0;
      double m = double.parse(parts[1]) / 100.0;
      double y = double.parse(parts[2]) / 100.0;
      double k = double.parse(parts[3]) / 100.0;

      // CMYK to RGB
      var r = 255 * (1 - c) * (1 - k);
      var g = 255 * (1 - m) * (1 - k);
      var b = 255 * (1 - y) * (1 - k);

      return Color.fromARGB(255, r.round().clamp(0, 255), g.round().clamp(0, 255), b.round().clamp(0, 255));
    } catch (_) {
      return null;
    }
  }

  static Color? fromHSV(String value) {
    // Expected format: "360°, 100%, 100%" or "360, 100, 100"
    try {
      final parts = value.replaceAll('°', '').replaceAll('%', '').replaceAll(' ', '').split(',');
      if (parts.length != 3) return null;

      double h = double.parse(parts[0]) % 360;
      double s = (double.parse(parts[1]) / 100).clamp(0.0, 1.0);
      double v = (double.parse(parts[2]) / 100).clamp(0.0, 1.0);

      return HSVColor.fromAHSV(1.0, h, s, v).toColor();
    } catch (_) {
      return null;
    }
  }
  
  static Color? fromHSL(String value) {
      // Expected format: "360°, 100%, 50%"
      try {
        final parts = value.replaceAll('°', '').replaceAll('%', '').replaceAll(' ', '').split(',');
        if (parts.length != 3) return null;

        double h = double.parse(parts[0]) % 360;
        double s = (double.parse(parts[1]) / 100).clamp(0.0, 1.0);
        double l = (double.parse(parts[2]) / 100).clamp(0.0, 1.0);

        return HSLColor.fromAHSL(1.0, h, s, l).toColor();
      } catch (_) {
        return null;
      }
    }
}
