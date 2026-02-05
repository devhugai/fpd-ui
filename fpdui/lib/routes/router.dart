/// Responsible for application routing configuration.
/// Provides GoRouter provider with all defined routes.
///
/// Used by: MyApp (main.dart).
/// Depends on: go_router, flutter_riverpod.
/// Assumes: URL-based navigation strategy.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../pages/docs/introduction_page.dart';
import '../pages/docs/installation_page.dart';
import '../pages/docs/button_page.dart';
import '../pages/docs/badge_page.dart';
import '../pages/docs/avatar_page.dart';
import '../pages/docs/card_page.dart';
import '../pages/docs/separator_page.dart';
import '../pages/docs/skeleton_page.dart';
import '../pages/docs/label_page.dart';
import '../pages/docs/input_page.dart';
import '../pages/docs/textarea_page.dart';
import '../pages/docs/checkbox_page.dart';
import '../pages/docs/switch_page.dart';
import '../pages/docs/radio_group_page.dart';
import '../pages/docs/slider_page.dart';
import '../pages/docs/progress_page.dart';
import '../pages/docs/form_page.dart';
import '../pages/docs/dialog_page.dart';
import '../pages/docs/alert_page.dart'; 
import '../pages/docs/alert_dialog_page.dart';
import '../pages/docs/select_page.dart';
import '../pages/docs/toggle_page.dart';
import '../pages/docs/spinner_page.dart';
import '../pages/docs/input_otp_page.dart';
import '../pages/docs/date_picker_page.dart';
import '../pages/docs/fab_page.dart';
import '../pages/docs/snackbar_page.dart';
import '../pages/docs/list_page.dart';
import '../pages/docs/toggle_group_page.dart';
import '../pages/docs/drawer_page.dart';
import '../pages/docs/sheet_page.dart';
import '../pages/docs/popover_page.dart';
import '../pages/docs/pagination_page.dart';
import '../pages/docs/menubar_page.dart';
import '../pages/docs/hover_card_page.dart';
import '../pages/docs/combobox_page.dart';
import '../pages/docs/aspect_ratio_page.dart';
import '../pages/docs/kbd_page.dart';
import '../pages/docs/app_bar_page.dart';
import '../pages/docs/navigation_bar_page.dart';
import '../pages/docs/navigation_rail_page.dart';
import '../pages/docs/navigation_drawer_page.dart';
import '../pages/docs/tab_bar_page.dart';
import '../pages/docs/time_picker_page.dart';
import '../pages/docs/tooltip_page.dart';
import '../pages/docs/toast_page.dart';
import '../pages/docs/context_menu_page.dart';
import '../pages/docs/dropdown_menu_page.dart';
import '../pages/docs/accordion_page.dart';
import '../pages/docs/collapsible_page.dart';
import '../pages/docs/tabs_page.dart';
import '../pages/docs/scroll_area_page.dart';
import '../pages/docs/resizable_page.dart';
import '../pages/docs/sidebar_page.dart';
import '../pages/docs/navigation_menu_page.dart';
import '../pages/docs/breadcrumb_page.dart';
import '../pages/docs/table_page.dart';
import '../pages/docs/data_table_page.dart';
import '../pages/docs/command_page.dart';
import '../pages/docs/calendar_page.dart';
import '../pages/docs/chart_page.dart';
import '../pages/docs/carousel_page.dart';
import '../pages/docs/typography_page.dart';
import '../pages/docs/colors_page.dart';
import '../pages/docs/radius_page.dart';
import '../pages/docs/borders_page.dart';
import '../pages/docs/shadows_page.dart';
import '../pages/docs/spacing_page.dart';
import '../pages/docs/color_picker_page.dart';
import '../pages/docs/sizes_page.dart';
import '../pages/docs/sizes_page.dart';
import '../shell/docs_shell.dart';
import '../shell/global_shell.dart';
import '../pages/home_page.dart';
import '../pages/sink_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return GlobalShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          ShellRoute(
            builder: (context, state, child) {
              return DocsShell(child: child);
            },
            routes: [
              GoRoute(
                path: '/docs/introduction',
                builder: (context, state) => const IntroductionPage(),
              ),
              GoRoute(
                path: '/docs/installation',
                builder: (context, state) => const InstallationPage(),
              ),
              GoRoute(
                path: '/docs/typography',
                builder: (context, state) => const TypographyPage(),
              ),
              GoRoute(
                path: '/docs/colors',
                builder: (context, state) => const ColorsPage(),
              ),
              GoRoute(
                path: '/docs/radius',
                builder: (context, state) => const RadiusPage(),
              ),
              GoRoute(
                path: '/docs/borders',
                builder: (context, state) => const BordersPage(),
              ),
              GoRoute(
                path: '/docs/shadows',
                builder: (context, state) => const ShadowsPage(),
              ),
              GoRoute(
                path: '/docs/spacing',
                builder: (context, state) => const SpacingPage(),
              ),
              GoRoute(
                path: '/docs/sizes',
                builder: (context, state) => const SizesPage(),
              ),
              GoRoute(
                path: '/docs/components/button',
                builder: (context, state) => const ButtonPage(),
              ),
              GoRoute(
                path: '/docs/components/fab',
                builder: (context, state) => const FabPage(),
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
                path: '/docs/components/list',
                builder: (context, state) => const ListPage(),
              ),
              GoRoute(
                path: '/docs/components/menubar',
                builder: (context, state) => const MenubarPage(),
              ),
              GoRoute(
                path: '/docs/components/hover-card',
                builder: (context, state) => const HoverCardPage(),
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
                path: '/docs/components/drawer',
                builder: (context, state) => const DrawerPage(),
              ),
              GoRoute(
                path: '/docs/components/alert',
                builder: (context, state) => const AlertPage(),
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
                path: '/docs/components/pagination',
                builder: (context, state) => const PaginationPage(),
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
                path: '/docs/components/snackbar',
                builder: (context, state) => const SnackbarPage(),
              ),
              GoRoute(
                path: '/docs/components/select',
                builder: (context, state) => const SelectPage(),
              ),
              GoRoute(
                path: '/docs/components/toggle',
                builder: (context, state) => const TogglePage(),
              ),
              GoRoute(
                path: '/docs/components/toggle-group',
                builder: (context, state) => const ToggleGroupPage(),
              ),
              GoRoute(
                path: '/docs/components/input-otp',
                builder: (context, state) => const InputOTPPage(),
              ),
              GoRoute(
                path: '/docs/components/spinner',
                builder: (context, state) => const SpinnerPage(),
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
                path: '/docs/components/date-picker',
                builder: (context, state) => const DatePickerPage(),
              ),
              GoRoute(
                path: '/docs/components/combobox',
                builder: (context, state) => const ComboboxPage(),
              ),
              GoRoute(
                path: '/docs/components/aspect-ratio',
                builder: (context, state) => const AspectRatioPage(),
              ),
              GoRoute(
                path: '/docs/components/kbd',
                builder: (context, state) => const KbdPage(),
              ),
              GoRoute(
                path: '/docs/components/app-bar',
                builder: (context, state) => const AppBarPage(),
              ),
              GoRoute(
                path: '/docs/components/navigation-bar',
                builder: (context, state) => const NavigationBarPage(),
              ),
              GoRoute(
                path: '/docs/components/navigation-rail',
                builder: (context, state) => const NavigationRailPage(),
              ),
              GoRoute(
                path: '/docs/components/navigation-drawer',
                builder: (context, state) => const NavigationDrawerPage(),
              ),
              GoRoute(
                path: '/docs/components/tab-bar',
                builder: (context, state) => const TabBarPage(),
              ),
              GoRoute(
                path: '/docs/components/time-picker',
                builder: (context, state) => const TimePickerPage(),
              ),
              GoRoute(
                path: '/docs/components/command',
                builder: (context, state) => const CommandPage(),
              ),
              GoRoute(
                path: '/docs/components/calendar',
                builder: (context, state) => const CalendarPage(),
              ),
              GoRoute(
                path: '/docs/components/chart',
                builder: (context, state) => const ChartPage(),
              ),
              GoRoute(
                path: '/docs/components/carousel',
                builder: (context, state) => const CarouselPage(),
              ),
              GoRoute(
                path: '/docs/components/color-picker',
                builder: (context, state) => const ColorPickerPage(),
              ),
            ],
          ),
          GoRoute(
            path: '/sink',
            builder: (context, state) => const SinkPage(),
          ),
        ],
      ),
    ],
  );
});
