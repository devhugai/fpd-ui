/// Responsible for the documentation layout shell.
/// Provides the structure for documentation pages with sidebar and content area.
///
/// Used by: Router (ShellRoute).
/// Depends on: docs_sidebar, fpdui_theme.
/// Assumes: Wraps child route.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/sidebar.dart';
import '../components/button.dart';
import '../components/separator.dart';
import '../theme/fpdui_theme.dart';
import 'docs_sidebar.dart';
import '../components/theme_configurator.dart'; // Import ThemeConfigurator

class DocsShell extends StatefulWidget {
  const DocsShell({super.key, required this.child});
  final Widget child;

  @override
  State<DocsShell> createState() => _DocsShellState();
}

class _DocsShellState extends State<DocsShell> {
  bool _isRightSidebarOpen = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return FpduiSidebarProvider(
      child: Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Row(
          children: [
            // Desktop Sidebar
            const FpduiSidebar(
              children: [Expanded(child: DocsSidebarContent())],
            ),
            // Main Content
            Expanded(
              child: Column(
                children: [
                  // Header (Mobile Trigger + Breadcrumbs / Actions)
                  Container(
                    height: 56, // h-14
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: fpduiTheme.border)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        const FpduiSidebarTrigger(),
                        const SizedBox(width: 8),
                         const Text("Docs", style: TextStyle(fontWeight: FontWeight.bold)),
                        // Add Breadcrumbs here later
                        const Spacer(),
                        // Theme Toggle Button
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isRightSidebarOpen = !_isRightSidebarOpen;
                            });
                          },
                          icon: Icon(
                            LucideIcons.settings,
                            color: _isRightSidebarOpen ? fpduiTheme.primary : fpduiTheme.foreground,
                          ),
                          tooltip: 'Toggle Theme Configurator',
                        ),
                      ],
                    ),
                  ),
                  // Page Content
                  Expanded(
                    child: widget.child,
                  ),
                ],
              ),
            ),
            // Right Sidebar (Theme Configurator)
            if (isDesktop && _isRightSidebarOpen) ...[
              const VerticalDivider(width: 1),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    Container(
                      height: 56,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: fpduiTheme.border)),
                      ),
                      child: const Text("Theme", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16),
                        child: ThemeConfigurator(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
