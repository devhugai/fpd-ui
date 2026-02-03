import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'shadcn_theme.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    colorScheme: const ColorScheme.light(
      background: Colors.white,
      onBackground: Color(0xff09090b), // zinc-950
      surface: Colors.white,
      onSurface: Color(0xff09090b),
      primary: Color(0xff18181b), // zinc-900
      onPrimary: Color(0xfffafafa), // zinc-50
      secondary: Color(0xfff4f4f5), // zinc-100
      onSecondary: Color(0xff18181b),
      error: Color(0xffef4444), // red-500
      onError: Colors.white,
      outline: Color(0xffe4e4e7), // zinc-200
    ),
    extensions: const [
      ShadcnTheme(
        background: Colors.white,
        foreground: Color(0xff09090b),
        card: Colors.white,
        cardForeground: Color(0xff09090b),
        popover: Colors.white,
        popoverForeground: Color(0xff09090b),
        primary: Color(0xff18181b),
        primaryForeground: Color(0xfffafafa),
        secondary: Color(0xfff4f4f5),
        secondaryForeground: Color(0xff18181b),
        muted: Color(0xfff4f4f5),
        mutedForeground: Color(0xff71717a), // zinc-500
        accent: Color(0xfff4f4f5),
        accentForeground: Color(0xff18181b),
        destructive: Color(0xffef4444),
        destructiveForeground: Color(0xfffafafa),
        border: Color(0xffe4e4e7),
        input: Color(0xffe4e4e7),
        ring: Color(0xff18181b),
        radius: 0.5, // 0.5rem approx 8.0 logic? No, shadcn uses rem. 0.5rem = 8px usually. Let's use 8.0.
      ),
    ],
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.inter().fontFamily,
    colorScheme: const ColorScheme.dark(
      background: Color(0xff09090b),
      onBackground: Color(0xfffafafa),
      surface: Color(0xff09090b),
      onSurface: Color(0xfffafafa),
      primary: Color(0xfffafafa),
      onPrimary: Color(0xff18181b),
      secondary: Color(0xff27272a), // zinc-800
      onSecondary: Color(0xfffafafa),
      error: Color(0xff7f1d1d), // red-900
      onError: Colors.white,
      outline: Color(0xff27272a),
    ),
    extensions: const [
      ShadcnTheme(
        background: Color(0xff09090b),
        foreground: Color(0xfffafafa),
        card: Color(0xff09090b),
        cardForeground: Color(0xfffafafa),
        popover: Color(0xff09090b),
        popoverForeground: Color(0xfffafafa),
        primary: Color(0xfffafafa),
        primaryForeground: Color(0xff18181b),
        secondary: Color(0xff27272a),
        secondaryForeground: Color(0xfffafafa),
        muted: Color(0xff27272a),
        mutedForeground: Color(0xffa1a1aa), // zinc-400
        accent: Color(0xff27272a),
        accentForeground: Color(0xfffafafa),
        destructive: Color(0xff7f1d1d),
        destructiveForeground: Color(0xfffafafa),
        border: Color(0xff27272a),
        input: Color(0xff27272a),
        ring: Color(0xffd4d4d8), // zinc-300
        radius: 8.0,
      ),
    ],
  );
}
