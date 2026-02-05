/// Responsible for displaying documentation for Card component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: card.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../components/card.dart';
import '../../components/button.dart';
import 'component_page.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Card',
      description: 'Displays a card with header, content, and footer.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Simple Card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
           FpduiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const FpduiCardHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FpduiCardTitle(child: Text('Card Title')),
                      FpduiCardDescription(child: Text('Card Description')),
                    ],
                  ),
                ),
                FpduiCardContent(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Card Content'),
                      const Gap(8),
                      const Text('This is the content of the card. It can be anything.'),
                    ],
                  ),
                ),
                 FpduiCardFooter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                       FpduiButton(text: 'Action'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(32),
          const Text('Action Card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Gap(16),
          FpduiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FpduiCardHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          FpduiCardTitle(child: Text('Create project')),
                          FpduiCardDescription(child: Text('Deploy your new project in one-click.')),
                      ],
                    )
                ),
                FpduiCardContent(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                          Text('Framework', style: TextStyle(fontSize: 14)),
                          Gap(8),
                          // Select Mockup
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text('Next.js'),
                          ),
                      ],
                  ),
                ),
                FpduiCardFooter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       FpduiButton(variant: FpduiButtonVariant.outline, text: 'Cancel'),
                       FpduiButton(text: 'Deploy'),
                    ],
                  ),
                ),
              ],
            ),
          ),
           const Gap(32),
           const Text('Notifications', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
           const Gap(16),
           FpduiCard(
               child: Column(
                   children: [
                        const FpduiCardHeader(
                           child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                   FpduiCardTitle(child: Text('Notifications')),
                                   FpduiCardDescription(child: Text('You have 3 unread messages.')),
                               ],
                           ),
                       ),
                       FpduiCardContent(
                           child: Column(
                               children: List.generate(3, (index) => 
                                   Padding(
                                       padding: const EdgeInsets.only(bottom: 16),
                                       child: Row(
                                           children: [
                                               const Icon(LucideIcons.bell, size: 24),
                                               const Gap(16),
                                               const Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                       Text('Your call has been confirmed.', style: TextStyle(fontWeight: FontWeight.w500)),
                                                       Text('1 hour ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                                   ],
                                               ),
                                           ],
                                       ),
                                   )
                               ),
                           ),
                       ),
                        FpduiCardFooter(
                           child: FpduiButton(
                               width: double.infinity,
                               text: 'Mark all as read',
                               icon: const Icon(LucideIcons.check),
                           ),
                       ),
                   ],
               ),
           ),
        ],
      ),
    );
  }
}
