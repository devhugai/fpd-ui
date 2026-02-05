import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fpdui_theme.dart';

class AppTheme {
  static ThemeData build({
    required Brightness brightness,
    Color? primaryColor,
    double radius = 0.5,
  }) {
    final isDark = brightness == Brightness.dark;
    final baseScheme = isDark ? const ColorScheme.dark() : const ColorScheme.light();
    
    // Default Zinc colors
    // Light
    final lightBackground = Colors.white;
    final lightForeground = const Color(0xff09090b);
    final lightCard = Colors.white;
    final lightCardForeground = const Color(0xff09090b);
    final lightPopover = Colors.white;
    final lightPopoverForeground = const Color(0xff09090b);
    final lightPrimary = primaryColor ?? const Color(0xff18181b);
    final lightPrimaryForeground = const Color(0xfffafafa);
    final lightSecondary = const Color(0xfff4f4f5);
    final lightSecondaryForeground = const Color(0xff18181b);
    final lightMuted = const Color(0xfff4f4f5);
    final lightMutedForeground = const Color(0xff71717a);
    final lightAccent = const Color(0xfff4f4f5);
    final lightAccentForeground = const Color(0xff18181b);
    final lightDestructive = const Color(0xffef4444);
    final lightDestructiveForeground = const Color(0xfffafafa);
    final lightBorder = const Color(0xffd4d4d8);
    final lightInput = const Color(0xffd4d4d8);
    final lightRing = const Color(0xff18181b);
    final lightSuccess = const Color(0xff22c55e); // green-500
    final lightSuccessForeground = const Color(0xfffafafa);
    final lightWarning = const Color(0xfff59e0b); // amber-500
    final lightWarningForeground = const Color(0xfffafafa);
    final lightInfo = const Color(0xff3b82f6); // blue-500
    final lightInfoForeground = const Color(0xfffafafa);
    final lightShadow = Colors.black.withOpacity(0.1);
    final lightOverlay = Colors.black.withOpacity(0.5);

    // Dark
    final darkBackground = const Color(0xff09090b);
    final darkForeground = const Color(0xfffafafa);
    final darkCard = const Color(0xff09090b);
    final darkCardForeground = const Color(0xfffafafa);
    final darkPopover = const Color(0xff09090b);
    final darkPopoverForeground = const Color(0xfffafafa);
    final darkPrimary = primaryColor ?? const Color(0xfffafafa);
    final darkPrimaryForeground = const Color(0xff18181b);
    final darkSecondary = const Color(0xff27272a);
    final darkSecondaryForeground = const Color(0xfffafafa);
    final darkMuted = const Color(0xff27272a);
    final darkMutedForeground = const Color(0xffa1a1aa);
    final darkAccent = const Color(0xff27272a);
    final darkAccentForeground = const Color(0xfffafafa);
    final darkDestructive = const Color(0xff7f1d1d);
    final darkDestructiveForeground = const Color(0xfffafafa);
    final darkBorder = const Color(0xff27272a);
    final darkInput = const Color(0xff27272a);
    final darkRing = const Color(0xffd4d4d8);
    final darkSuccess = const Color(0xff22c55e); // green-500
    final darkSuccessForeground = const Color(0xfffafafa);
    final darkWarning = const Color(0xfff59e0b); // amber-500
    final darkWarningForeground = const Color(0xfffafafa);
    final darkInfo = const Color(0xff3b82f6); // blue-500
    final darkInfoForeground = const Color(0xfffafafa);
    final darkShadow = Colors.black.withOpacity(0.3); // Slightly darker shadow for dark mode visibility? or standard.
    final darkOverlay = Colors.black.withOpacity(0.5);

    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      brightness: brightness,
      colorScheme: baseScheme.copyWith(
        background: isDark ? darkBackground : lightBackground,
        onBackground: isDark ? darkForeground : lightForeground,
        surface: isDark ? darkCard : lightCard,
        onSurface: isDark ? darkCardForeground : lightCardForeground,
        primary: isDark ? darkPrimary : lightPrimary, // Native primary used for some widgets
        onPrimary: isDark ? darkPrimaryForeground : lightPrimaryForeground,
        secondary: isDark ? darkSecondary : lightSecondary,
        onSecondary: isDark ? darkSecondaryForeground : lightSecondaryForeground,
        error: isDark ? darkDestructive : lightDestructive,
        onError: isDark ? darkDestructiveForeground : lightDestructiveForeground,
        outline: isDark ? darkBorder : lightBorder, // using border color for outline
      ),
      extensions: [
        FpduiTheme(
          background: isDark ? darkBackground : lightBackground,
          foreground: isDark ? darkForeground : lightForeground,
          card: isDark ? darkCard : lightCard,
          cardForeground: isDark ? darkCardForeground : lightCardForeground,
          popover: isDark ? darkPopover : lightPopover,
          popoverForeground: isDark ? darkPopoverForeground : lightPopoverForeground,
          primary: isDark ? darkPrimary : lightPrimary,
          primaryForeground: isDark ? darkPrimaryForeground : lightPrimaryForeground,
          secondary: isDark ? darkSecondary : lightSecondary,
          secondaryForeground: isDark ? darkSecondaryForeground : lightSecondaryForeground,
          muted: isDark ? darkMuted : lightMuted,
          mutedForeground: isDark ? darkMutedForeground : lightMutedForeground,
          accent: isDark ? darkAccent : lightAccent,
          accentForeground: isDark ? darkAccentForeground : lightAccentForeground,
          destructive: isDark ? darkDestructive : lightDestructive,
          destructiveForeground: isDark ? darkDestructiveForeground : lightDestructiveForeground,
          border: isDark ? darkBorder : lightBorder,
          input: isDark ? darkInput : lightInput,
          ring: isDark ? darkRing : lightRing,
          radius: radius * 16.0, 
          radiusSm: (radius * 16.0) - 2.0, // radius-sm
          radiusLg: (radius * 16.0) + 2.0, // radius-lg
          radiusXl: (radius * 16.0) + 4.0, // radius-xl (approx)
          // Default was 0.5 (web rem?) -> 8.0 px. So multiplier 16 seems right if 0.5 is default.
          success: isDark ? darkSuccess : lightSuccess,
          successForeground: isDark ? darkSuccessForeground : lightSuccessForeground,
          warning: isDark ? darkWarning : lightWarning,
          warningForeground: isDark ? darkWarningForeground : lightWarningForeground,
          info: isDark ? darkInfo : lightInfo,
          infoForeground: isDark ? darkInfoForeground : lightInfoForeground,
          shadow: isDark ? darkShadow : lightShadow,
          overlay: isDark ? darkOverlay : lightOverlay,
        ),
      ],
    );
  }
}
