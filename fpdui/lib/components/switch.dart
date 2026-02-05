/// Responsible for boolean toggle.
/// Provides FpduiSwitch widget.
///
/// Used by: Settings, activation states.
/// Depends on: fpdui_theme.
/// Assumes: Boolean state controlled via onChanged.
import 'package:flutter/material.dart';
import '../theme/fpdui_theme.dart';

class FpduiSwitch extends StatelessWidget {
  const FpduiSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;

    // shadcn specs:
    // w-[44px] h-[24px] (h-6 w-11 approx, from radix default usually, but shadcn default size is h-[1.15rem] w-8 which is ~ h-5 w-9 in tailwind rems? No.
    // Source: "data-[size=default]:h-[1.15rem] data-[size=default]:w-8" -> h ~ 18.4px, w ~ 32px.
    // That seems small. Let's check visually. Standard iOS switch is 51x31.
    // Shadcn switch is notoriously small/sleek.
    // Let's stick to the css values: h-[1.15rem] (18.4px) w-9 (36px).
    // Wait source says: `data-[size=default]:h-[1.15rem] data-[size=default]:w-8`
    // 1 rem = 16px. 1.15 * 16 = 18.4px. w-8 = 2rem = 32px.
    // This is quite small. Let's use 20px height and 36px width for better touch target/visibility in mobile or stick to source?
    // Let's stick closer to source but maybe round up for flutter pixels: 20px height, 36px width.
    
    // Colors:
    // checked: bg-primary
    // unchecked: bg-input
    // thumb: bg-background

    const height = 20.0;
    const width = 36.0;
    const padding = 2.0;
    const thumbSize = height - (padding * 2); // 16px

    return GestureDetector(
      onTap: enabled ? () => onChanged?.call(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width,
        height: height,
        padding: const EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), // rounded-full
          color: value 
              ? theme.colorScheme.primary 
              : fpduiTheme.input,
          border: Border.all(
            color: Colors.transparent, // transparent border in css
            width: 0,
          ),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                      color: fpduiTheme.shadow,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
