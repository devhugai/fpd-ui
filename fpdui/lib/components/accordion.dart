/// Responsible for displaying collapsible content panels.
/// Provides FpduiAccordion and FpduiAccordionItem widgets.
///
/// Used by: Settings pages, FAQs, detailed views.
/// Depends on: fpdui_theme, flutter/material.
/// Assumes: Children are provided as a list of items.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

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

enum FpduiAccordionType { single, multiple }

class _FpduiAccordionState extends State<FpduiAccordion> {
  final List<String> _expandedIds = [];

  void _toggle(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        if (widget.type == FpduiAccordionType.single) {
          _expandedIds.clear();
        }
        _expandedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.children.map((item) {
        return _FpduiAccordionItemWrapper(
          item: item,
          isExpanded: _expandedIds.contains(item.value), // Use value as ID
          onToggle: () => _toggle(item.value),
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
    // This widget is just a configuration holder, rendered by wrapper.
    return const SizedBox.shrink();
  }
}

class _FpduiAccordionItemWrapper extends StatelessWidget {
  const _FpduiAccordionItemWrapper({
    required this.item,
    required this.isExpanded,
    required this.onToggle,
  });

  final FpduiAccordionItem item;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: fpduiTheme.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: onToggle,
            hoverColor: Colors.transparent, // or hover:underline style? shadcn uses hover:underline on text
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16), // py-4
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500, // font-medium
                        color: theme.colorScheme.onBackground,
                      ) ?? const TextStyle(),
                      child: item.trigger, // We might want to add hover:underline via MouseRegion if we want strict fidelity
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0, // 180deg
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      LucideIcons.chevronDown,
                      size: 16,
                      color: fpduiTheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: SizedBox( // explicit width needed? No, Column stretches.
              width: double.infinity,
              child: isExpanded
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16), // pb-4
                      child: DefaultTextStyle(
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onBackground, // or generic text
                        ) ?? const TextStyle(),
                        child: item.content
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
