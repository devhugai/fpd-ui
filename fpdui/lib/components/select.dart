/// Responsible for selecting a value from a list of options.
/// Provides FpduiSelect and FpduiSelectItem.
///
/// Used by: Forms, filters.
/// Depends on: fpdui_theme, lucide_icons.
/// Assumes: Popover-style dropdown behavior.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

class FpduiSelectItem<T> {
  final T value;
  final Widget child;
  final bool enabled;

  const FpduiSelectItem({
    required this.value,
    required this.child,
    this.enabled = true,
  });
}

class FpduiSelect<T> extends StatefulWidget {
  const FpduiSelect({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.placeholder,
    this.width,
  });

  final T? value;
  final ValueChanged<T> onChanged;
  final List<FpduiSelectItem<T>> items;
  final Widget? placeholder;
  final double? width;

  @override
  State<FpduiSelect<T>> createState() => _FpduiSelectState<T>();
}

class _FpduiSelectState<T> extends State<FpduiSelect<T>> {
  final LayerLink _layerLink = LayerLink();
  final OverlayPortalController _overlayController = OverlayPortalController();
  final FocusNode _focusNode = FocusNode();
  
  // Track trigger size to match content width
  Size? _triggerSize;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
     // _hide(); // Optional: close on focus loss? 
     // Usually handled by TapRegion
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _hide() {
    if (_overlayController.isShowing) {
      _overlayController.hide();
    }
  }

  void _toggle() {
    _triggerSize = context.size;
    _overlayController.toggle();
    if (_overlayController.isShowing) {
      _focusNode.requestFocus();
    }
  }

  void _select(T value) {
    widget.onChanged(value);
    _hide();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // Find selected item widget to display
    final selectedItem = widget.items.where((i) => i.value == widget.value).firstOrNull;
    final displayContent = selectedItem?.child ?? 
                          widget.placeholder != null ? DefaultTextStyle(
                            style: theme.textTheme.bodyMedium!.copyWith(color: fpduiTheme.mutedForeground),
                            child: widget.placeholder!, 
                          ) : const SizedBox();

    return CompositedTransformTarget(
      link: _layerLink,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return Positioned(
            width: _triggerSize?.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft,
              followerAnchor: Alignment.topLeft,
              offset: const Offset(0, 4),
              child: Align(
                alignment: Alignment.topLeft,
                child: TapRegion(
                  groupId: _layerLink,
                  onTapOutside: (event) => _hide(),
                  child: _SelectDropdown<T>(
                    items: widget.items,
                    selectedValue: widget.value,
                    onSelect: _select,
                    width: _triggerSize?.width,
                  ),
                ),
              ),
            ),
          );
        },
        child: TapRegion(
          groupId: _layerLink,
          child: InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(fpduiTheme.radius),
            child: Container(
              height: 40,
              width: widget.width,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(fpduiTheme.radius),
                border: Border.all(color: fpduiTheme.input),
                color: theme.colorScheme.background,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: DefaultTextStyle(
                      style: theme.textTheme.bodyMedium!,
                      overflow: TextOverflow.ellipsis,
                      child: displayContent is Widget ? displayContent : Text((displayContent ?? '').toString()),
                    ),
                  ),
                  Icon(LucideIcons.chevronDown, size: 16, color: fpduiTheme.mutedForeground.withOpacity(0.5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectDropdown<T> extends StatelessWidget {
  const _SelectDropdown({
    required this.items,
    required this.selectedValue,
    required this.onSelect,
    required this.width,
  });

  final List<FpduiSelectItem<T>> items;
  final T? selectedValue;
  final ValueChanged<T> onSelect;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    return Material(
      color: Colors.transparent,
      child: Container(
        // minWidth: 100 or matching trigger
        width: width,
        constraints: const BoxConstraints(maxHeight: 300),
        decoration: BoxDecoration(
          color: fpduiTheme.popover,
          borderRadius: BorderRadius.circular(fpduiTheme.radius),
          border: Border.all(color: fpduiTheme.border),
          boxShadow: [
            BoxShadow(
              color: fpduiTheme.shadow,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(4),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            final isSelected = item.value == selectedValue;

            return InkWell(
              onTap: item.enabled ? () => onSelect(item.value) : null,
              borderRadius: BorderRadius.circular(fpduiTheme.radiusSm),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(fpduiTheme.radiusSm),
                  color: isSelected ? fpduiTheme.accent : null,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                      child: isSelected
                          ? Icon(LucideIcons.check, size: 14, color: fpduiTheme.accentForeground)
                          : null,
                    ),
                    const Gap(8),
                    Expanded(
                      child: DefaultTextStyle(
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: item.enabled 
                              ? (isSelected ? fpduiTheme.accentForeground : fpduiTheme.popoverForeground)
                              : fpduiTheme.mutedForeground,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                        ),
                        child: item.child,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
