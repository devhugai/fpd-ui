/// Responsible for displaying collapsible content panels.
/// Provides FpduiAccordion and FpduiAccordionItem widgets.
///
/// Used by: Settings pages, FAQs, detailed views.
/// Depends on: fpdui_theme, flutter/material.
/// Assumes: Children are provided as a list of items.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

enum FpduiAccordionType { single, multiple }

class FpduiAccordion extends StatefulWidget {
  const FpduiAccordion({
    super.key,
    required this.children,
    this.type = FpduiAccordionType.single,
  });

  final List<FpduiAccordionItem> children;
  final FpduiAccordionType type;

  @override
  State<FpduiAccordion> createState() => _FpduiAccordionState();
}

class _FpduiAccordionState extends State<FpduiAccordion> {
  // Store controllers to manage single expansion mode
  late Map<String, ExpansionTileController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (var item in widget.children) item.value: ExpansionTileController(),
    };
  }

  @override
  void didUpdateWidget(FpduiAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
       _controllers = {
        for (var item in widget.children) item.value: ExpansionTileController(),
      };
    }
  }

  void _onExpansionChanged(String id, bool expanded) {
    if (widget.type == FpduiAccordionType.single && expanded) {
      // Close all others
      _controllers.forEach((key, controller) {
        if (key != id && controller.isExpanded) {
           controller.collapse();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Column(
      children: widget.children.map<Widget>((item) {
        final border = Border(bottom: BorderSide(color: fpduiTheme.border));
        
        return ExpansionTile(
          key: Key(item.value), // Important for state
          controller: _controllers[item.value],
          title: DefaultTextStyle(
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500, // font-medium
              color: theme.colorScheme.onBackground,
            ) ?? const TextStyle(),
            child: item.trigger,
          ),
          tilePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0), // px-0 py-4 handled by ExpansionTile height usually
          // ExpansionTile default height is min 56 usually. shadcn py-4 is 16px. 
          // We can adjust via visualDensity or padding.
          childrenPadding: const EdgeInsets.only(bottom: 16), // pb-4
          
          // Style override to match shadcn
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          iconColor: fpduiTheme.mutedForeground,
          collapsedIconColor: fpduiTheme.mutedForeground,
          shape: border,
          collapsedShape: border,
          showTrailingIcon: true,
          trailing: Icon(LucideIcons.chevronDown, size: 16), // ExpansionTile animates rotation automatically?
          // Default expansion tile rotates trailing icon. 
          
          onExpansionChanged: (expanded) => _onExpansionChanged(item.value, expanded),
          children: [
             SizedBox(
                width: double.infinity,
                child: DefaultTextStyle(
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground, 
                  ) ?? const TextStyle(),
                  child: item.content
                ),
             )
          ],
        );
      }).toList(),
    ); 
  }
}

class FpduiAccordionItem extends StatelessWidget {
  const FpduiAccordionItem({
    super.key,
    required this.value,
    required this.trigger,
    required this.content,
  });

  final String value; // Unique ID
  final Widget trigger; // Header content (usually text)
  final Widget content; // Body content

  @override
  Widget build(BuildContext context) {
    // Configuration widget, not rendered directly
    return const SizedBox.shrink();
  }
}


