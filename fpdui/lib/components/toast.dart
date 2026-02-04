import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

class FpduiToast {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static OverlayState? get _overlay => navigatorKey.currentState?.overlay;

  static void show(
    BuildContext context, 
    String title, {
    String? description,
    FpduiToastVariant variant = FpduiToastVariant.defaultVariant,
    Duration duration = const Duration(seconds: 4),
    Widget? action,
  }) {
    // If we have a global key we could use it, but for now we rely on context 
    // or we assume the user wraps the app with a Toaster widget.
    // Let's implement a singleton manager approach via a robust overlay entry or custom Toaster.
    
    // Better yet, let's look for the nearest _ToasterState.
    final toaster = context.findAncestorStateOfType<_ToasterState>();
    if (toaster != null) {
      toaster.addToast(title, description, variant, duration, action);
    } else {
      debugPrint('FpduiToast: No Toaster found in context. Wrap your app in FpduiToaster.');
    }
  }
}

enum FpduiToastVariant { defaultVariant, destructive, success, warning, info }

class FpduiToaster extends StatefulWidget {
  const FpduiToaster({super.key, required this.child});
  final Widget child;

  @override
  State<FpduiToaster> createState() => _ToasterState();
}

class _ToasterState extends State<FpduiToaster> {
  final List<_ToastEntry> _toasts = [];

  void addToast(String title, String? description, FpduiToastVariant variant, Duration duration, Widget? action) {
    setState(() {
      final id = DateTime.now().toString();
      _toasts.add(_ToastEntry(
        id: id,
        title: title,
        description: description,
        variant: variant,
        duration: duration,
        action: action,
      ));
    });
  }

  void removeToast(String id) {
    setState(() {
      _toasts.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Positioned(
          bottom: 16,
          right: 16, // Default position bottom-right
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _toasts.map((toast) => _ToastWidget(
                key: ValueKey(toast.id),
                entry: toast,
                onDismiss: () => removeToast(toast.id),
              )).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToastEntry {
  _ToastEntry({
    required this.id,
    required this.title,
    this.description,
    required this.variant,
    required this.duration,
    this.action,
  });

  final String id;
  final String title;
  final String? description;
  final FpduiToastVariant variant;
  final Duration duration;
  final Widget? action;
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({super.key, required this.entry, required this.onDismiss});

  final _ToastEntry entry;
  final VoidCallback onDismiss;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, 
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 200),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
       CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

    _timer = Timer(widget.entry.duration, () {
      _dismiss();
    });
  }
  
  void _dismiss() {
     _controller.reverse().then((_) {
       if (mounted) widget.onDismiss();
     });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    Color bgColor = theme.colorScheme.background; // bg-background (typically popover)
    Color textColor = theme.colorScheme.onBackground;
    Color borderColor = fpduiTheme.border;
    IconData? icon;
    Color iconColor = textColor;

    switch (widget.entry.variant) {
      case FpduiToastVariant.destructive:
        bgColor = theme.colorScheme.error;
        textColor = theme.colorScheme.onError;
        borderColor = theme.colorScheme.error;
         icon = LucideIcons.alertOctagon;
         iconColor = textColor;
        break;
      case FpduiToastVariant.success:
        icon = LucideIcons.checkCircle;
        iconColor = Colors.green;
        break;
      case FpduiToastVariant.warning:
        icon = LucideIcons.alertTriangle;
        iconColor = Colors.amber;
        break;
       case FpduiToastVariant.info:
        icon = LucideIcons.info;
        iconColor = Colors.blue;
        break;
      default:
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
           if (details.primaryVelocity! > 0) _dismiss(); // Swipe right to dismiss
        },
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: 356, // fixed width typically or constrained? Shadcn toasts usually width-full sm:w-[356px]
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(fpduiTheme.radius),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                     Icon(icon, size: 16, color: iconColor),
                     const Gap(12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.entry.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        if (widget.entry.description != null) ...[
                          const Gap(4),
                          Text(
                            widget.entry.description!,
                            style: TextStyle(
                              fontSize: 12, // text-sm
                              color: textColor.withOpacity(0.8), // muted-foreground equivalent-ish
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                   if (widget.entry.action != null) ...[
                     const Gap(12),
                     widget.entry.action!,
                   ],
                   const Gap(12),
                   InkWell(
                     onTap: _dismiss,
                     child: Icon(LucideIcons.x, size: 14, color: textColor.withOpacity(0.5)),
                   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
