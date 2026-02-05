/// Responsible for the application's main navigation sidebar.
/// Provides FpduiSidebar container and items.
///
/// Used by: AppShell, main layout.
/// Depends on: fpdui_theme, lucide_icons.
/// Assumes: Collapsible state management.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';
import 'button.dart';
import 'sheet.dart';
import 'tooltip.dart';
import 'separator.dart';
import 'input.dart';

// Constants
const double _kSidebarWidth = 256.0; // 16rem
const double _kSidebarWidthMobile = 288.0; // 18rem
const double _kSidebarWidthIcon = 48.0; // 3rem

class FpduiSidebarProvider extends StatefulWidget {
  const FpduiSidebarProvider({
    super.key,
    required this.child,
    this.defaultOpen = true,
    this.onOpenChange,
  });

  final Widget child;
  final bool defaultOpen;
  final ValueChanged<bool>? onOpenChange;

  static FpduiSidebarProviderState of(BuildContext context) {
    final _SidebarProviderScope? scope = 
        context.dependOnInheritedWidgetOfExactType<_SidebarProviderScope>();
    if (scope == null) {
      throw FlutterError('FpduiSidebarProvider.of() called with a context that does not contain a FpduiSidebarProvider.');
    }
    return scope.data;
  }

  @override
  State<FpduiSidebarProvider> createState() => FpduiSidebarProviderState();
}

class FpduiSidebarProviderState extends State<FpduiSidebarProvider> {
  late bool _open;
  bool _openMobile = false;

  bool get open => _open;
  bool get openMobile => _openMobile;
  
  // Basic mobile detection based on screen width
  bool get isMobile => MediaQuery.of(context).size.width < 768; // md breakpoint

  @override
  void initState() {
    super.initState();
    _open = widget.defaultOpen;
  }

  void setOpen(bool value) {
    if (_open != value) {
      setState(() => _open = value);
      widget.onOpenChange?.call(value);
    }
  }

  void setOpenMobile(bool value) {
    if (_openMobile != value) {
      setState(() => _openMobile = value);
    }
  }

  void toggleSidebar() {
    if (isMobile) {
      setOpenMobile(!_openMobile);
    } else {
      setOpen(!_open);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _SidebarProviderScope(
      data: this,
      open: _open,
      openMobile: _openMobile,
      isMobile: isMobile,
      child: widget.child,
    );
  }
}

class _SidebarProviderScope extends InheritedWidget {
  const _SidebarProviderScope({
    required this.data,
    required this.open,
    required this.openMobile,
    required this.isMobile,
    required super.child,
  });

  final FpduiSidebarProviderState data;
  final bool open;
  final bool openMobile;
  final bool isMobile;

  @override
  bool updateShouldNotify(_SidebarProviderScope oldWidget) {
    return open != oldWidget.open || 
           openMobile != oldWidget.openMobile ||
           isMobile != oldWidget.isMobile;
  }
}

enum FpduiSidebarVariant { sidebar, floating, inset }
enum FpduiSidebarCollapsible { offcanvas, icon, none }
enum FpduiSidebarSide { left, right }

class FpduiSidebar extends StatelessWidget {
  const FpduiSidebar({
    super.key,
    required this.children,
    this.side = FpduiSidebarSide.left,
    this.variant = FpduiSidebarVariant.sidebar,
    this.collapsible = FpduiSidebarCollapsible.offcanvas,
  });

  final List<Widget> children;
  final FpduiSidebarSide side;
  final FpduiSidebarVariant variant;
  final FpduiSidebarCollapsible collapsible;

  @override
  Widget build(BuildContext context) {
    final provider = FpduiSidebarProvider.of(context);
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    if (collapsible == FpduiSidebarCollapsible.none) {
      return Container(
        width: _kSidebarWidth,
        color: fpduiTheme.background, // bg-sidebar
        child: Column(children: children),
      );
    }

    if (provider.isMobile) {
      return FpduiSheet(
        open: provider.openMobile,
        onOpenChange: provider.setOpenMobile,
        side: side == FpduiSidebarSide.left ? FpduiSheetSide.left : FpduiSheetSide.right,
        content: FpduiSheetContent(
          // No explicit styling for sheet content yet in primitive, using default
          // Ideally we customize sheet width to _kSidebarWidthMobile
          child: Column(children: children),
        ),
      );
    }

    // Desktop
    final state = provider.open ? 'expanded' : 'collapsed';
    
    // Width calculation
    double width = _kSidebarWidth;
    if (state == 'collapsed') {
       if (collapsible == FpduiSidebarCollapsible.icon) {
         width = _kSidebarWidthIcon;
       } else if (collapsible == FpduiSidebarCollapsible.offcanvas) {
         width = 0;
       }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      decoration: BoxDecoration(
        color: theme.colorScheme.background, // bg-sidebar
        border: Border(
          right: side == FpduiSidebarSide.left ? BorderSide(color: fpduiTheme.border) : BorderSide.none,
          left: side == FpduiSidebarSide.right ? BorderSide(color: fpduiTheme.border) : BorderSide.none,
        ),
      ),
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topLeft,
          minWidth: collapsible == FpduiSidebarCollapsible.icon && state == 'collapsed' 
              ? _kSidebarWidthIcon 
              : _kSidebarWidth,
          maxWidth: _kSidebarWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}

class FpduiSidebarTrigger extends StatelessWidget {
  const FpduiSidebarTrigger({super.key});

  @override
  Widget build(BuildContext context) {
    return FpduiButton(
      variant: FpduiButtonVariant.ghost,
      size: FpduiButtonSize.icon,
      onPressed: () => FpduiSidebarProvider.of(context).toggleSidebar(),
      child: const Icon(LucideIcons.panelLeft, size: 16),
    );
  }
}

class FpduiSidebarInset extends StatelessWidget {
  const FpduiSidebarInset({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: child);
  }
}

class FpduiSidebarHeader extends StatelessWidget {
  const FpduiSidebarHeader({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}

class FpduiSidebarContent extends StatelessWidget {
  const FpduiSidebarContent({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: children,
      ),
    );
  }
}

class FpduiSidebarFooter extends StatelessWidget {
  const FpduiSidebarFooter({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }
}

class FpduiSidebarMenu extends StatelessWidget {
  const FpduiSidebarMenu({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class FpduiSidebarMenuItem extends StatelessWidget {
  const FpduiSidebarMenuItem({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: child,
    );
  }
}

class FpduiSidebarMenuButton extends StatelessWidget {
  const FpduiSidebarMenuButton({
    super.key,
    required this.child,
    this.isActive = false,
    this.onTap,
    this.tooltip,
    this.icon,
  });

  final Widget child;
  final bool isActive;
  final VoidCallback? onTap;
  final String? tooltip;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final provider = FpduiSidebarProvider.of(context);
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    final bool isCollapsed = !provider.open && !provider.isMobile && 
        // Assuming we can access the collapsible mode from here? 
        // No, we don't know the parent Sidebar mode directly without context traversal or provider storage.
        // For now, assume if width is small -> icon mode.
        // Or better: Just check provider.open
        !provider.open;
        
    // If collapsed, we show only icon if present, or first char?
    // Proper icon mode requires hiding text.
    
    Widget content = Row(
      children: [
        if (icon != null) ...[
          IconTheme(
            data: IconThemeData(
              size: 16,
              color: isActive ? theme.colorScheme.onSecondary : theme.colorScheme.onBackground,
            ),
            child: icon!,
          ),
        ],
        if (!isCollapsed || provider.isMobile) ...[
          if (icon != null) const Gap(8),
          Expanded(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? theme.colorScheme.onSecondary : theme.colorScheme.onBackground,
              ),
              child: child,
            ),
          ),
        ],
      ],
    );

    Widget button = InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(fpduiTheme.radius),
      child: Container(
        constraints: const BoxConstraints(minHeight: 32),
        padding: EdgeInsets.symmetric(
          horizontal: 8, 
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
        ),
        child: content,
      ),
    );

    if (isCollapsed && tooltip != null) {
      return FpduiTooltip(
        message: tooltip,
        side: AxisDirection.right,
        child: button,
      );
    }

    return button;
  }
}

class FpduiSidebarGroup extends StatelessWidget {
  const FpduiSidebarGroup({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class FpduiSidebarGroupLabel extends StatelessWidget {
  const FpduiSidebarGroupLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final provider = FpduiSidebarProvider.of(context);
    if (!provider.isMobile && !provider.open) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onBackground.withOpacity(0.5),
        ),
      ),
    );
  }
}

class FpduiSidebarSeparator extends StatelessWidget {
  const FpduiSidebarSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: FpduiSeparator(),
    );
  }
}
