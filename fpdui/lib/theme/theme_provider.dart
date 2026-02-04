import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Theme Mode Provider
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

// Theme Configuration Providers
final themeRadiusProvider = StateProvider<double>((ref) => 0.5);
final themeColorProvider = StateProvider<Color>((ref) => const Color(0xFF09090b)); // Zinc-950 (Light) / White (Dark) handled in AppTheme? 
// No, primary color usually is distinct (e.g. Blue, Green, Orange). 
// The default shadcn uses Zinc (Black/White), but we want to allow picking "Blue" as primary.
// Let's store a "ThemeColor" object or just a base color.
// For simplicity, let's store the base Primary Color.
final themePrimaryColorProvider = StateProvider<Color>((ref) => Colors.black); 
// Note: "Zinc" isn't a single color, it's a slate/gray. 
// Shadcn themes are "Zinc", "Slate", "Stone", "Gray", "Neutral", "Red", "Rose", "Orange", "Green", "Blue", "Yellow", "Violet".
// Each has a set of colors.
// For this MVP, let's just allow changing the `Radius` and a simple `Primary` color override.
