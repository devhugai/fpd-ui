/// Responsible for displaying documentation for Button component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: button.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/button.dart';
import 'component_page.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Button',
      description: 'Displays a button or a component that looks like a button.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Variants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FpduiButton(
                text: 'Primary',
                onPressed: () {},
              ),
              FpduiButton(
                variant: FpduiButtonVariant.secondary,
                text: 'Secondary',
                onPressed: () {},
              ),
              FpduiButton(
                variant: FpduiButtonVariant.destructive,
                text: 'Destructive',
                onPressed: () {},
              ),
              FpduiButton(
                variant: FpduiButtonVariant.outline,
                text: 'Outline',
                onPressed: () {},
              ),
              FpduiButton(
                variant: FpduiButtonVariant.ghost,
                text: 'Ghost',
                onPressed: () {},
              ),
              FpduiButton(
                variant: FpduiButtonVariant.link,
                text: 'Link',
                onPressed: () {},
              ),
            ],
          ),
          const Gap(32),
          const Text('Sizes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 16,
            children: [
              FpduiButton(
                size: FpduiButtonSize.lg,
                text: 'Large',
                onPressed: () {},
              ),
              FpduiButton(
                size: FpduiButtonSize.$default,
                text: 'Default',
                onPressed: () {},
              ),
              FpduiButton(
                size: FpduiButtonSize.sm,
                text: 'Small',
                onPressed: () {},
              ),
            ],
          ),
          const Gap(32),
          const Text('Icons', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FpduiButton(
                text: 'With Icon',
                icon: const Icon(LucideIcons.mail),
                onPressed: () {},
              ),
              FpduiButton(
                text: 'Trailing Icon',
                trailingIcon: const Icon(LucideIcons.arrowRight),
                onPressed: () {},
              ),
              FpduiButton(
                size: FpduiButtonSize.icon,
                child: const Icon(LucideIcons.chevronRight, size: 16),
                onPressed: () {},
              ),
            ],
          ),
          const Gap(32),
          const Text('Disabled', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
               const FpduiButton(
                text: 'Disabled',
                onPressed: null,
              ),
               const FpduiButton(
                variant: FpduiButtonVariant.secondary,
                text: 'Disabled',
                onPressed: null,
              ),
              const FpduiButton(
                variant: FpduiButtonVariant.outline,
                text: 'Disabled',
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
