/// Responsible for initializing the application and global providers.
/// Provides the root widget structure, including theme and routing.
///
/// Used by: Flutter framework (entry point).
/// Depends on: flutter_riverpod, routemaster, app_theme.
/// Assumes: main() is the solitary entry point.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);
    final radius = ref.watch(themeRadiusProvider);
    final primaryColor = ref.watch(themePrimaryColorProvider);
    final fontFamily = ref.watch(themeFontFamilyProvider);

    return MaterialApp.router(
      title: 'FPD UI',
      theme: AppTheme.build(
        brightness: Brightness.light,
        radius: radius,
        primaryColor: primaryColor,
        fontFamily: fontFamily,
      ),
      darkTheme: AppTheme.build(
        brightness: Brightness.dark,
        radius: radius,
        primaryColor: primaryColor,
        fontFamily: fontFamily,
      ),
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
