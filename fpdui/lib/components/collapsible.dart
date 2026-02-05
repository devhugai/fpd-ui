/// Responsible for showing/hiding content sections.
/// Provides FpduiCollapsible widget.
///
/// Used by: Sidebars, advanced options.
/// Depends on: fpdui_theme.
/// Assumes: Controlled or uncontrolled state.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

class FpduiCollapsible extends StatefulWidget {
  const FpduiCollapsible({
    super.key,
    required this.trigger,
    required this.content,
    this.disabled = false,
    this.initialOpen = false,
    this.controller,
  });

  final Widget trigger;
  final Widget content;
  final bool disabled;
  final bool initialOpen;
  final FpduiCollapsibleController? controller;

  @override
  State<FpduiCollapsible> createState() => _FpduiCollapsibleState();
}

class _FpduiCollapsibleState extends State<FpduiCollapsible> {
  late bool _isOpen;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initialOpen;
    widget.controller?._attach(this);
  }

  @override
  void dispose() {
    widget.controller?._detach();
    super.dispose();
  }

  void toggle() {
    if (widget.disabled) return;
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  void setIsOpen(bool value) {
     if (widget.disabled) return;
     if (_isOpen != value) {
       setState(() {
         _isOpen = value;
       });
     }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Trigger wrapper? The styling implies trigger is arbitrary.
        // We assume the user passes a trigger that might call toggle or we wrap it.
        // Shadcn CollapsibleTrigger usually handles the click.
        // Here we expose a public toggle via controller or context?
        // Simpler for Flutter: Wrap trigger in GestureDetector if it's not interactive.
        // But better: Just let trigger be a widget and provide a context method?
        // Let's implement trigger as a direct child that taps to toggle.
        GestureDetector(
          onTap: toggle,
          behavior: HitTestBehavior.translucent, // Allow headers to capture taps
          child: widget.trigger,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: SizedBox(
             width: double.infinity,
             child: _isOpen ? widget.content : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

class FpduiCollapsibleController {
  _FpduiCollapsibleState? _state;

  void _attach(_FpduiCollapsibleState state) {
    _state = state;
  }
  
  void _detach() {
    _state = null;
  }

  void toggle() => _state?.toggle();
  void setIsOpen(bool value) => _state?.setIsOpen(value);
  bool get isOpen => _state?._isOpen ?? false;
}

// Optional helper for standard trigger styling if needed, but rarely strict in shadcn.
// We can provide a FpduiCollapsibleTrigger similar to Button if requested.
