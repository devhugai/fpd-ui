/// Responsible for building the Flutter ThemeData.
/// Provides static factories for light and dark themes using FpduiTheme extensions.
///
/// Used by: MyApp (main.dart).
/// Depends on: fpdui_theme, google_fonts.
/// Assumes: Brightness is provided to toggle modes.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fpdui_theme.dart';

class AppTheme {
  static ThemeData build({
    required Brightness brightness,
    Color? primaryColor,
    Map<String, Color> colorOverrides = const {},
    double radius = 0.5,
    String fontFamily = 'Inter',
    double fontScale = 1.0,
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

    // Helper to get effective color
    Color get(String key, Color defaultColor) {
      if (colorOverrides.containsKey(key)) {
        return colorOverrides[key]!;
      }
      return defaultColor;
    }

    // Apply Overrides
    final effectiveBackground = get('background', isDark ? darkBackground : lightBackground);
    final effectiveForeground = get('foreground', isDark ? darkForeground : lightForeground);
    final effectiveCard = get('card', isDark ? darkCard : lightCard);
    final effectiveCardForeground = get('cardForeground', isDark ? darkCardForeground : lightCardForeground);
    final effectivePopover = get('popover', isDark ? darkPopover : lightPopover);
    final effectivePopoverForeground = get('popoverForeground', isDark ? darkPopoverForeground : lightPopoverForeground);
    final effectivePrimary = get('primary', isDark ? darkPrimary : lightPrimary);
    final effectivePrimaryForeground = get('primaryForeground', isDark ? darkPrimaryForeground : lightPrimaryForeground);
    final effectiveSecondary = get('secondary', isDark ? darkSecondary : lightSecondary);
    final effectiveSecondaryForeground = get('secondaryForeground', isDark ? darkSecondaryForeground : lightSecondaryForeground);
    final effectiveMuted = get('muted', isDark ? darkMuted : lightMuted);
    final effectiveMutedForeground = get('mutedForeground', isDark ? darkMutedForeground : lightMutedForeground);
    final effectiveAccent = get('accent', isDark ? darkAccent : lightAccent);
    final effectiveAccentForeground = get('accentForeground', isDark ? darkAccentForeground : lightAccentForeground);
    final effectiveDestructive = get('destructive', isDark ? darkDestructive : lightDestructive);
    final effectiveDestructiveForeground = get('destructiveForeground', isDark ? darkDestructiveForeground : lightDestructiveForeground);
    final effectiveBorder = get('border', isDark ? darkBorder : lightBorder);
    final effectiveInput = get('input', isDark ? darkInput : lightInput);
    final effectiveRing = get('ring', isDark ? darkRing : lightRing);
    final effectiveSuccess = get('success', isDark ? darkSuccess : lightSuccess);
    final effectiveSuccessForeground = get('successForeground', isDark ? darkSuccessForeground : lightSuccessForeground);
    final effectiveWarning = get('warning', isDark ? darkWarning : lightWarning);
    final effectiveWarningForeground = get('warningForeground', isDark ? darkWarningForeground : lightWarningForeground);
    final effectiveInfo = get('info', isDark ? darkInfo : lightInfo);
    final effectiveInfoForeground = get('infoForeground', isDark ? darkInfoForeground : lightInfoForeground);
    final effectiveShadow = get('shadow', isDark ? darkShadow : lightShadow);
    final effectiveOverlay = get('overlay', isDark ? darkOverlay : lightOverlay);

    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.getFont(fontFamily).fontFamily,
      brightness: brightness,
      textTheme: GoogleFonts.getTextTheme(fontFamily).apply(
        fontSizeFactor: fontScale,
      ),
      colorScheme: baseScheme.copyWith(
        background: effectiveBackground,
        onBackground: effectiveForeground,
        surface: effectiveCard,
        onSurface: effectiveCardForeground,
        primary: effectivePrimary, // Native primary used for some widgets
        onPrimary: effectivePrimaryForeground,
        secondary: effectiveSecondary,
        onSecondary: effectiveSecondaryForeground,
        error: effectiveDestructive,
        onError: effectiveDestructiveForeground,
        outline: effectiveBorder, // using border color for outline
      ),
      extensions: [
        FpduiTheme(
          background: effectiveBackground,
          foreground: effectiveForeground,
          card: effectiveCard,
          cardForeground: effectiveCardForeground,
          popover: effectivePopover,
          popoverForeground: effectivePopoverForeground,
          primary: effectivePrimary,
          primaryForeground: effectivePrimaryForeground,
          secondary: effectiveSecondary,
          secondaryForeground: effectiveSecondaryForeground,
          muted: effectiveMuted,
          mutedForeground: effectiveMutedForeground,
          accent: effectiveAccent,
          accentForeground: effectiveAccentForeground,
          destructive: effectiveDestructive,
          destructiveForeground: effectiveDestructiveForeground,
          border: effectiveBorder,
          input: effectiveInput,
          ring: effectiveRing,
          radius: radius * 16.0, 
          radiusSm: (radius * 16.0) - 2.0, // radius-sm
          radiusLg: (radius * 16.0) + 2.0, // radius-lg
          radiusXl: (radius * 16.0) + 4.0, // radius-xl (approx)
          // Default was 0.5 (web rem?) -> 8.0 px. So multiplier 16 seems right if 0.5 is default.
          success: effectiveSuccess,
          successForeground: effectiveSuccessForeground,
          warning: effectiveWarning,
          warningForeground: effectiveWarningForeground,
          info: effectiveInfo,
          infoForeground: effectiveInfoForeground,
          shadow: effectiveShadow,
          overlay: effectiveOverlay,
        ),
      ],
    );
  }
}
