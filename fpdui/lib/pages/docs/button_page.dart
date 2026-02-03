import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/button.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Variants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                ShadcnButton(
                  text: 'Primary',
                  onPressed: () {},
                ),
                ShadcnButton(
                  variant: ShadcnButtonVariant.secondary,
                  text: 'Secondary',
                  onPressed: () {},
                ),
                ShadcnButton(
                  variant: ShadcnButtonVariant.destructive,
                  text: 'Destructive',
                  onPressed: () {},
                ),
                ShadcnButton(
                  variant: ShadcnButtonVariant.outline,
                  text: 'Outline',
                  onPressed: () {},
                ),
                ShadcnButton(
                  variant: ShadcnButtonVariant.ghost,
                  text: 'Ghost',
                  onPressed: () {},
                ),
                ShadcnButton(
                  variant: ShadcnButtonVariant.link,
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
                ShadcnButton(
                  size: ShadcnButtonSize.lg,
                  text: 'Large',
                  onPressed: () {},
                ),
                ShadcnButton(
                  size: ShadcnButtonSize.$default,
                  text: 'Default',
                  onPressed: () {},
                ),
                ShadcnButton(
                  size: ShadcnButtonSize.sm,
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
                ShadcnButton(
                  text: 'With Icon',
                  icon: const Icon(LucideIcons.mail),
                  onPressed: () {},
                ),
                ShadcnButton(
                  text: 'Trailing Icon',
                  trailingIcon: const Icon(LucideIcons.arrowRight),
                  onPressed: () {},
                ),
                ShadcnButton(
                  size: ShadcnButtonSize.icon,
                  icon: const Icon(LucideIcons.chevronRight),
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
                 const ShadcnButton(
                  text: 'Disabled',
                  onPressed: null,
                ),
                 const ShadcnButton(
                  variant: ShadcnButtonVariant.secondary,
                  text: 'Disabled',
                  onPressed: null,
                ),
                const ShadcnButton(
                  variant: ShadcnButtonVariant.outline,
                  text: 'Disabled',
                  onPressed: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
