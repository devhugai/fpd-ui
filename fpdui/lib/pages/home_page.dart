/// Responsible for the landing page view.
/// Provides entry point buttons to docs and sink.
///
/// Used by: Root route ('/').
/// Depends on: fpdui components.
/// Assumes: Marketing-style layout.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/button.dart';
import '../theme/theme_provider.dart';

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
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Checkbox',
            onPressed: () => context.push('/docs/components/checkbox'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Switch',
            onPressed: () => context.push('/docs/components/switch'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Radio Group',
            onPressed: () => context.push('/docs/components/radio-group'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Slider',
            onPressed: () => context.push('/docs/components/slider'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Progress',
            onPressed: () => context.push('/docs/components/progress'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Form',
            onPressed: () => context.push('/docs/components/form'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Dialog',
            onPressed: () => context.push('/docs/components/dialog'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Alert Dialog',
            onPressed: () => context.push('/docs/components/alert-dialog'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Sheet',
            onPressed: () => context.push('/docs/components/sheet'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Popover',
            onPressed: () => context.push('/docs/components/popover'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Tooltip',
            onPressed: () => context.push('/docs/components/tooltip'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Toast / Sonner',
            onPressed: () => context.push('/docs/components/toast'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Context Menu',
            onPressed: () => context.push('/docs/components/context-menu'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Dropdown Menu',
            onPressed: () => context.push('/docs/components/dropdown-menu'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 16),
          const Text('Navigation & Layout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Navigation Menu',
            onPressed: () => context.push('/docs/components/navigation-menu'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Breadcrumb',
            onPressed: () => context.push('/docs/components/breadcrumb'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Accordion',
            onPressed: () => context.push('/docs/components/accordion'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Collapsible',
            onPressed: () => context.push('/docs/components/collapsible'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Tabs',
            onPressed: () => context.push('/docs/components/tabs'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Scroll Area',
            onPressed: () => context.push('/docs/components/scroll-area'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Resizable',
            onPressed: () => context.push('/docs/components/resizable'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Sidebar',
            onPressed: () => context.push('/docs/components/sidebar'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 16),
          const Text('Data Display', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Table',
            onPressed: () => context.push('/docs/components/table'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Data Table',
            onPressed: () => context.push('/docs/components/data-table'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Command / Palette',
            onPressed: () => context.push('/docs/components/command'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Calendar',
            onPressed: () => context.push('/docs/components/calendar'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Charts',
            onPressed: () => context.push('/docs/components/chart'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
          const SizedBox(height: 8),
          FpduiButton(
            variant: FpduiButtonVariant.outline,
            text: 'Carousel',
            onPressed: () => context.push('/docs/components/carousel'),
            trailingIcon: const Icon(LucideIcons.arrowRight, size: 16),
          ),
        ],
      ),
    );
  }
}
