import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/sidebar.dart';
import '../components/button.dart';
import '../components/separator.dart';
import '../theme/fpdui_theme.dart';
import 'docs_sidebar.dart';
import '../components/theme_toggle.dart';

class DocsShell extends StatelessWidget {
  const DocsShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

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
                        // Theme Toggle
                        const ThemeToggle(),
                      ],
                    ),
                  ),
                  // Page Content
                  Expanded(
                    child: child,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
