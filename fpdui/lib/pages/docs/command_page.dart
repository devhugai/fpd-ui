import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:gap/gap.dart';
import '../../components/command.dart';
import '../../components/card.dart';
import '../../components/button.dart';

class CommandPage extends StatelessWidget {
  const CommandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Command')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Embedded Command', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              width: 450,
              child: FpduiCommand(
                decoration: BoxDecoration(
                   color: Theme.of(context).cardColor,
                   border: Border.all(color: Colors.grey.withOpacity(0.2)),
                   borderRadius: BorderRadius.circular(8),
                ),
                children: [
                   FpduiCommandInput(
                     placeholder: "Type a command or search...",
                     onChanged: (val) {},
                   ),
                   FpduiCommandList(
                     children: [
                       const FpduiCommandEmpty("No results found."),
                       FpduiCommandGroup(
                         heading: "Suggestions",
                         children: [
                           FpduiCommandItem(
                             child: Row(children: [const Icon(LucideIcons.calendar), const Gap(8), const Text("Calendar")]),
                           ),
                            FpduiCommandItem(
                             child: Row(children: [const Icon(LucideIcons.smile), const Gap(8), const Text("Search Emoji")]),
                           ),
                            FpduiCommandItem(
                             child: Row(children: [const Icon(LucideIcons.calculator), const Gap(8), const Text("Calculator")]),
                           ),
                         ],
                       ),
                       const FpduiCommandSeparator(),
                       FpduiCommandGroup(
                         heading: "Settings",
                         children: [
                           FpduiCommandItem(
                             child: Row(
                               children: [
                                 const Icon(LucideIcons.user), 
                                 const Gap(8), 
                                 const Text("Profile"),
                                 const Spacer(),
                                 const FpduiCommandShortcut("⌘P"),
                               ],
                             ),
                           ),
                           FpduiCommandItem(
                             child: Row(
                               children: [
                                 const Icon(LucideIcons.creditCard), 
                                 const Gap(8), 
                                 const Text("Billing"),
                                 const Spacer(),
                                 const FpduiCommandShortcut("⌘B"),
                               ],
                             ),
                           ),
                           FpduiCommandItem(
                             child: Row(
                               children: [
                                 const Icon(LucideIcons.settings), 
                                 const Gap(8), 
                                 const Text("Settings"),
                                 const Spacer(),
                                 const FpduiCommandShortcut("⌘S"),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                ],
              ),
            ),
             const SizedBox(height: 32),
             FpduiButton(
               text: "Open Command Dialog (Example)",
               onPressed: () {
                 FpduiCommandDialog.show(
                   context,
                   child: FpduiCommand(
                    children: [
                       const FpduiCommandInput(),
                       FpduiCommandList(
                         children: [
                            FpduiCommandGroup(
                              heading: "Actions",
                              children: [
                                FpduiCommandItem(child: const Text("New File"), onSelect: (){ Navigator.pop(context); }),
                                FpduiCommandItem(child: const Text("Copy Link"), onSelect: (){ Navigator.pop(context); }),
                              ],
                            ),
                         ],
                       ),
                    ],
                   ),
                 );
               },
             ),
          ],
        ),
      ),
    );
  }
}
