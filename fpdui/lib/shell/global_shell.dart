/// Responsible for the global application layout.
/// Provides a persistent left NavigationRail.
///
/// Used by: Router (ShellRoute).
/// Depends on: go_router, lucide_icons, fpdui_theme.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

class GlobalShell extends StatelessWidget {
  const GlobalShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // Check current path to determine active destination (optional, for styling)
    final String location = GoRouterState.of(context).matchedLocation;
    final bool isDocs = location.startsWith('/docs');

    return Scaffold(
      body: Row(
        children: [
          // Global Navigation Rail
          Container(
            width: 72,
            decoration: BoxDecoration(
              color: theme.colorScheme.background,
              border: Border(right: BorderSide(color: fpduiTheme.border)),
            ),
            child: Column(
              children: [
                const Gap(16),
                // Logo -> Home
                InkWell(
                  onTap: () => context.go('/'),
                  customBorder: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/dashatars/dashatars.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                const Gap(24),
                
                // Docs Button
                _NavRailButton(
                  icon: LucideIcons.bookOpen,
                  label: 'Docs',
                  isActive: isDocs,
                  onTap: () => context.go('/docs/introduction'),
                ),
                
                const Spacer(),
                // could add GitHub link or other global settings here
                const Gap(16),
              ],
            ),
          ),
          
          // Child Content (DocsShell, Home, etc.)
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _NavRailButton extends StatelessWidget {
  const _NavRailButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive ? fpduiTheme.secondary : null,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: isActive ? fpduiTheme.primary : fpduiTheme.mutedForeground,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
