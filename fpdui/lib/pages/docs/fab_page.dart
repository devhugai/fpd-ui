/// Responsible for displaying documentation for FAB component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: fab.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/fab.dart';
import '../../components/fab_menu.dart';
import 'component_page.dart';

class FabPage extends StatelessWidget {
  const FabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Floating Action Button',
      description: 'A primary action button that floats above content.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Variants', style: Theme.of(context).textTheme.titleSmall),
          const Gap(16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FpduiFAB(
                onPressed: () {},
                tooltip: 'Primary',
                child: const Icon(LucideIcons.plus),
              ),
              FpduiFAB(
                variant: FpduiFABVariant.secondary,
                onPressed: () {},
                 tooltip: 'Secondary',
                child: const Icon(LucideIcons.settings),
              ),
              FpduiFAB(
                variant: FpduiFABVariant.destructive,
                onPressed: () {},
                 tooltip: 'Destructive',
                child: const Icon(LucideIcons.trash2),
              ),
               FpduiFAB(
                variant: FpduiFABVariant.outline,
                onPressed: () {},
                 tooltip: 'Outline',
                child: const Icon(LucideIcons.pencil),
              ),
            ],
          ),
          const Gap(32),
          Text('Sizes', style: Theme.of(context).textTheme.titleSmall),
          const Gap(16),
          Wrap(
            spacing: 16,
             crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FpduiFAB(
                size: FpduiFABSize.sm,
                onPressed: () {},
                 tooltip: 'Small',
                child: const Icon(LucideIcons.plus),
              ),
              FpduiFAB(
                size: FpduiFABSize.defaultSize,
                onPressed: () {},
                 tooltip: 'Default',
                child: const Icon(LucideIcons.plus),
              ),
              FpduiFAB(
                size: FpduiFABSize.lg,
                onPressed: () {},
                 tooltip: 'Large',
                child: const Icon(LucideIcons.plus),
              ),
            ],
          ),
          const Gap(32),
          Text('Expandable Menu', style: Theme.of(context).textTheme.titleSmall),
          const Gap(16),
          Align(
            alignment: Alignment.centerLeft, // Demo it without full screen layout first
            child: FpduiFabMenu(
              items: [
                FpduiFabAction(
                  icon: LucideIcons.image,
                  label: 'Add Image',
                  onPressed: () {},
                ),
                FpduiFabAction(
                  icon: LucideIcons.fileText,
                  label: 'New Document',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
