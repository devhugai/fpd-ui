import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'components/toast.dart'; // Import Toaster
import 'routes/router.dart';
import 'theme/app_theme.dart';
import 'theme/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'FPD UI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) {
        return FpduiToaster(
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
