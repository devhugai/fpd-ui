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
import 'pages/docs/checkbox_page.dart';
import 'pages/docs/switch_page.dart';
import 'pages/docs/radio_group_page.dart';
import 'pages/docs/slider_page.dart';
import 'pages/docs/progress_page.dart';
import 'pages/docs/form_page.dart';
import 'pages/docs/dialog_page.dart';
import 'pages/docs/alert_dialog_page.dart';
import 'pages/docs/sheet_page.dart';
import 'pages/docs/popover_page.dart';
import 'pages/docs/tooltip_page.dart';
import 'pages/docs/toast_page.dart';
import 'pages/docs/context_menu_page.dart';
import 'pages/docs/dropdown_menu_page.dart';
import 'pages/docs/accordion_page.dart';
import 'pages/docs/collapsible_page.dart';
import 'pages/docs/tabs_page.dart';
import 'pages/docs/scroll_area_page.dart';
import 'pages/docs/resizable_page.dart';
import 'pages/docs/sidebar_page.dart';
import 'pages/docs/navigation_menu_page.dart';
import 'pages/docs/breadcrumb_page.dart';
import 'pages/docs/table_page.dart';
import 'pages/docs/data_table_page.dart';
import 'pages/docs/command_page.dart';
import 'pages/docs/calendar_page.dart';
import 'components/toast.dart'; // Import Toaster
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
    GoRoute(
      path: '/docs/components/checkbox',
      builder: (context, state) => const CheckboxPage(),
    ),
    GoRoute(
      path: '/docs/components/switch',
      builder: (context, state) => const SwitchPage(),
    ),
    GoRoute(
      path: '/docs/components/radio-group',
      builder: (context, state) => const RadioGroupPage(),
    ),
    GoRoute(
      path: '/docs/components/slider',
      builder: (context, state) => const SliderPage(),
    ),
    GoRoute(
      path: '/docs/components/progress',
      builder: (context, state) => const ProgressPage(),
    ),
    GoRoute(
      path: '/docs/components/form',
      builder: (context, state) => const FormPage(),
    ),
    GoRoute(
      path: '/docs/components/dialog',
      builder: (context, state) => const DialogPage(),
    ),
    GoRoute(
      path: '/docs/components/alert-dialog',
      builder: (context, state) => const AlertDialogPage(),
    ),
    GoRoute(
      path: '/docs/components/sheet',
      builder: (context, state) => const SheetPage(),
    ),
    GoRoute(
      path: '/docs/components/popover',
      builder: (context, state) => const PopoverPage(),
    ),
    GoRoute(
      path: '/docs/components/tooltip',
      builder: (context, state) => const TooltipPage(),
    ),
    GoRoute(
      path: '/docs/components/toast',
      builder: (context, state) => const ToastPage(),
    ),
    GoRoute(
      path: '/docs/components/context-menu',
      builder: (context, state) => const ContextMenuPage(),
    ),
    GoRoute(
      path: '/docs/components/dropdown-menu',
      builder: (context, state) => const DropdownMenuPage(),
    ),
    GoRoute(
      path: '/docs/components/accordion',
      builder: (context, state) => const AccordionPage(),
    ),
    GoRoute(
      path: '/docs/components/collapsible',
      builder: (context, state) => const CollapsiblePage(),
    ),
    GoRoute(
      path: '/docs/components/tabs',
      builder: (context, state) => const TabsPage(),
    ),
    GoRoute(
      path: '/docs/components/scroll-area',
      builder: (context, state) => const ScrollAreaPage(),
    ),
    GoRoute(
      path: '/docs/components/resizable',
      builder: (context, state) => const ResizablePage(),
    ),
    GoRoute(
      path: '/docs/components/sidebar',
      builder: (context, state) => const SidebarPage(),
    ),
    GoRoute(
      path: '/docs/components/navigation-menu',
      builder: (context, state) => const NavigationMenuPage(),
    ),
    GoRoute(
      path: '/docs/components/breadcrumb',
      builder: (context, state) => const BreadcrumbPage(),
    ),
    GoRoute(
      path: '/docs/components/table',
      builder: (context, state) => const TablePage(),
    ),
    GoRoute(
      path: '/docs/components/data-table',
      builder: (context, state) => const DataTablePage(),
    ),
    GoRoute(
      path: '/docs/components/command',
      builder: (context, state) => const CommandPage(),
    ),
    GoRoute(
      path: '/docs/components/calendar',
      builder: (context, state) => const CalendarPage(),
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
      builder: (context, child) {
        return FpduiToaster(
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
