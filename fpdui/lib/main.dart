import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'components/button.dart';
import 'pages/docs/button_page.dart';
import 'pages/docs/badge_page.dart';
import 'pages/docs/avatar_page.dart';
import 'pages/docs/card_page.dart';
import 'pages/docs/separator_page.dart';
import 'pages/docs/skeleton_page.dart';
import 'pages/docs/label_page.dart';
import 'pages/docs/input_page.dart';
import 'pages/docs/textarea_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/docs/components/button',
      builder: (context, state) => const ButtonPage(),
    ),
    GoRoute(
      path: '/docs/components/badge',
      builder: (context, state) => const BadgePage(),
    ),
    GoRoute(
      path: '/docs/components/avatar',
      builder: (context, state) => const AvatarPage(),
    ),
    GoRoute(
      path: '/docs/components/card',
      builder: (context, state) => const CardPage(),
    ),
    GoRoute(
      path: '/docs/components/separator',
      builder: (context, state) => const SeparatorPage(),
    ),
    GoRoute(
      path: '/docs/components/skeleton',
      builder: (context, state) => const SkeletonPage(),
    ),
    GoRoute(
      path: '/docs/components/label',
      builder: (context, state) => const LabelPage(),
    ),
    GoRoute(
      path: '/docs/components/input',
      builder: (context, state) => const InputPage(),
    ),
    GoRoute(
      path: '/docs/components/textarea',
      builder: (context, state) => const TextareaPage(),
    ),
  ],
);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('FPD UI Showcase'),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark ? LucideIcons.sun : LucideIcons.moon),
            onPressed: () {
              ref.read(themeModeProvider.notifier).state = 
                  themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Primitives', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Button',
            onPressed: () => context.push('/docs/components/button'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Badge',
            onPressed: () => context.push('/docs/components/badge'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Avatar',
            onPressed: () => context.push('/docs/components/avatar'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Card',
            onPressed: () => context.push('/docs/components/card'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Separator',
            onPressed: () => context.push('/docs/components/separator'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Skeleton',
            onPressed: () => context.push('/docs/components/skeleton'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Label',
            onPressed: () => context.push('/docs/components/label'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
           FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Input',
            onPressed: () => context.push('/docs/components/input'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Textarea',
            onPressed: () => context.push('/docs/components/textarea'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
        ],
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'FPD UI',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
