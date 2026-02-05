// Responsible for displaying expandable FAB actions (Speed Dial).
// Provides FpduiFabMenu and FpduiFabAction.
//
// Used by: Screens with multiple primary actions.
// Depends on: fpdui_theme, flutter_animate (or native animations), fab.dart.
// Assumes: Bottom-right positioning usually.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';
import 'fab.dart';

class FpduiFabAction {
  final IconData icon;
  final String? label;
  final VoidCallback onPressed;

  const FpduiFabAction({
    required this.icon,
    required this.onPressed,
    this.label,
  });
}

class FpduiFabMenu extends StatefulWidget {
  const FpduiFabMenu({
    super.key,
    required this.items,
    this.icon = LucideIcons.plus,
    this.activeIcon = LucideIcons.x,
  });

  final List<FpduiFabAction> items;
  final IconData icon;
  final IconData activeIcon;

  @override
  State<FpduiFabMenu> createState() => _FpduiFabMenuState();
}

class _FpduiFabMenuState extends State<FpduiFabMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
     _rotateAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Wrap content
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Actions
        SizeTransition(
          sizeFactor: _expandAnimation,
          axisAlignment: -1.0, // Expand upwards
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               ...widget.items.map((item) {
                 return Padding(
                   padding: const EdgeInsets.only(bottom: 16.0),
                   child: _FabMenuItem(item: item, onClose: _toggle),
                 );
               }),
             ],
          ),
        ),
        
        // Trigger
        FpduiFAB(
          onPressed: _toggle,
          child: RotationTransition(
            turns: _rotateAnimation,
            child: Icon(_isOpen ? widget.activeIcon : widget.icon),
          ),
        ),
      ],
    );
  }
}

class _FabMenuItem extends StatelessWidget {
  const _FabMenuItem({required this.item, required this.onClose});

  final FpduiFabAction item;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (item.label != null) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(fpduiTheme.radius),
              boxShadow: [
                 BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                 ),
              ],
              border: Border.all(color: fpduiTheme.border),
            ),
            child: Text(
              item.label!,
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const Gap(12),
        ],
        
        // Mini FAB look
        SizedBox(
          width: 40,
          height: 40,
          child: FpduiFAB(
            size: FpduiFABSize.sm,
            variant: FpduiFABVariant.secondary,
            onPressed: () {
              onClose();
              item.onPressed();
            },
            child: Icon(item.icon, size: 18),
          ),
        ),
      ],
    );
  }
}
