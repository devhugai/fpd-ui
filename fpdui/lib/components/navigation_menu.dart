/// Responsible for displaying hierarchical navigation links.
/// Provides FpduiNavigationMenu and NavigationMenuItem.
///
/// Used by: Header navigation, main menus.
/// Depends on: fpdui_theme.
/// Assumes: Hover or click interactions triggers sub-menus.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../theme/fpdui_theme.dart';

// Controller to manage the active state and viewport processing
class FpduiNavigationMenuController extends ChangeNotifier {
  String? _activeValue;
  
  String? get activeValue => _activeValue;

  void setActive(String? value) {
    if (_activeValue != value) {
      _activeValue = value;
      notifyListeners();
    }
  }
}

class FpduiNavigationMenu extends StatefulWidget {
  const FpduiNavigationMenu({
    super.key,
    required this.children,
    this.controller,
  });

  final List<Widget> children; // Should be NavigationMenuList
  final FpduiNavigationMenuController? controller;

  @override
  State<FpduiNavigationMenu> createState() => _FpduiNavigationMenuState();
}

class _FpduiNavigationMenuState extends State<FpduiNavigationMenu> {
  late FpduiNavigationMenuController _controller;
  final LayerLink _viewportLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? FpduiNavigationMenuController();
  }

  @override
  Widget build(BuildContext context) {
    return _NavigationMenuScope(
      controller: _controller,
      viewportLink: _viewportLink,
      child: CompositedTransformTarget(
        link: _viewportLink,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widget.children,
        ),
      ),
    );
  }
}

class _NavigationMenuScope extends InheritedWidget {
  const _NavigationMenuScope({
    required this.controller,
    required this.viewportLink,
    required super.child,
  });

  final FpduiNavigationMenuController controller;
  final LayerLink viewportLink;

  static _NavigationMenuScope of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_NavigationMenuScope>()!;
  }

  @override
  bool updateShouldNotify(_NavigationMenuScope oldWidget) => 
      controller != oldWidget.controller;
}

class FpduiNavigationMenuList extends StatelessWidget {
  const FpduiNavigationMenuList({super.key, required this.children});
  
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

class FpduiNavigationMenuItem extends StatefulWidget {
  const FpduiNavigationMenuItem({
    super.key,
    this.value,
    required this.trigger, // The label/button
    this.content, // The dropdown content
  });

  final String? value; // Unique ID for this item logic
  final Widget trigger; 
  final Widget? content;

  @override
  State<FpduiNavigationMenuItem> createState() => _FpduiNavigationMenuItemState();
}

class _FpduiNavigationMenuItemState extends State<FpduiNavigationMenuItem> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final LayerLink _link = LayerLink();
  bool _isHoveringTrigger = false;
  bool _isHoveringContent = false;
  
  void _onEnterTrigger(PointerEvent _) {
    setState(() => _isHoveringTrigger = true);
    _show();
  }

  void _onExitTrigger(PointerEvent _) {
    setState(() => _isHoveringTrigger = false);
    _startHideTimer();
  }
  
  void _onEnterContent(PointerEvent _) {
    setState(() => _isHoveringContent = true);
  }

  void _onExitContent(PointerEvent _) {
    setState(() => _isHoveringContent = false);
    _startHideTimer();
  }

  void _show() {
    if (!_overlayController.isShowing) {
      _overlayController.show();
    }
  }

  void _startHideTimer() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      if (!_isHoveringTrigger && !_isHoveringContent) {
        _overlayController.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.content == null) {
      return widget.trigger;
    }

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return Positioned(
            width: 350, // Fixed width for content? or dynamic?
            child: CompositedTransformFollower(
              link: _link,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 10), // Gap
              child: MouseRegion(
                onEnter: _onEnterContent,
                onExit: _onExitContent,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 200),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * -10),
                        child: child,
                      ),
                    );
                  },
                  child: widget.content!,
                ),
              ),
            ),
          );
        },
        child: MouseRegion(
          onEnter: _onEnterTrigger,
          onExit: _onExitTrigger,
          child: widget.trigger,
        ),
      ),
    );
  }
}

// Re-thinking: The root must build the Viewport Overlay.
// The Viewport needs to know:
// 1. Where to position (relative to the active trigger? or relative to the list?)
//    Shadcn: Relative to the list center usually, but `NavigationMenuIndicator` follows the trigger.
//    The Viewport is usually centered below the list.
// 2. What content to show (the widget active).
// 3. Dimensions of the content to animate width/height.

// Let's implement a simpler "Single Overlay" at the root `FpduiNavigationMenu`.

class FpduiNavigationMenuTrigger extends StatelessWidget {
  const FpduiNavigationMenuTrigger({
    super.key,
    required this.child,
    this.isActive = false,
  });

  final Widget child;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    return Container(
       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
       decoration: BoxDecoration(
         color: isActive ? theme.colorScheme.secondary : Colors.transparent,
         borderRadius: BorderRadius.circular(fpduiTheme.radius),
       ),
       child: DefaultTextStyle(
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: isActive ? theme.colorScheme.onSecondary : theme.colorScheme.onBackground,
          ) ?? const TextStyle(),
         child: Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             child,
             const Gap(4),
             if (isActive) // Rotation handled by parent usually or generic
                Icon(LucideIcons.chevronUp, size: 12)
             else
                Icon(LucideIcons.chevronDown, size: 12),
           ],
         ),
       ),
    );
  }
}

// NOTE: Due to complexity, this file currently sets up the structure.
// I will implement a "Basic" version first that works like a Dropdown but styled as NavMenu,
// because full unified Viewport animation in Flutter is a heavy Flutter-Graph task 
// (requires measuring off-screen render objects or layout phases).

// PLAN B for MVP: Each item manages its own overlay content, but we style it to look cohesive.
// We can use `FpduiHoverCard` logic? Or just `Portal`.

class FpduiNavigationMenuContent extends StatelessWidget {
  const FpduiNavigationMenuContent({super.key, required this.child});
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    return Container(
      width: 300, // Default width or auto?
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fpduiTheme.popover, 
        border: Border.all(color: fpduiTheme.border),
        borderRadius: BorderRadius.circular(fpduiTheme.radius),
        boxShadow: [
          BoxShadow(
             color: fpduiTheme.shadow,
             blurRadius: 10,
             offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class FpduiNavigationMenuLink extends StatelessWidget {
  const FpduiNavigationMenuLink({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.onTap,
  });

  final String title;
  final String? description;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              icon!,
              const Gap(12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                     title,
                     style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600) ?? const TextStyle(fontWeight: FontWeight.w600),
                   ),
                   if (description != null) ...[
                     const Gap(4),
                     Text(
                       description!,
                       style: theme.textTheme.bodySmall?.copyWith(
                         color: theme.colorScheme.onBackground.withOpacity(0.7),
                       ) ?? const TextStyle(),
                     ),
                   ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
