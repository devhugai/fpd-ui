import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/collapsible.dart';
import '../../components/button.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CollapsiblePage extends StatefulWidget {
  const CollapsiblePage({super.key});

  @override
  State<CollapsiblePage> createState() => _CollapsiblePageState();
}

class _CollapsiblePageState extends State<CollapsiblePage> {
  final FpduiCollapsibleController _controller = FpduiCollapsibleController();
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collapsible')),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16),
          child: FpduiCollapsible(
            controller: _controller,
            trigger: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Text('@peduarte starred 3 repositories', 
                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)
                 ),
                 FpduiButton(
                   text: '',
                   width: 32, // sq-8 approx size-9 in shadcn
                   height: 32,
                   variant: FpduiButtonVariant.ghost,
                   onPressed: () {
                     _controller.toggle();
                     setState(() => _isOpen = !_isOpen);
                   },
                   child: Icon(LucideIcons.chevronsUpDown, size: 16),
                 ),
               ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(8),
                Container(
                   padding: const EdgeInsets.all(12),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey.withOpacity(0.2)),
                     borderRadius: BorderRadius.circular(6),
                   ),
                   child: const Text('@radix-ui/primitives', style: TextStyle(fontSize: 13)),
                ),
                 const Gap(8),
                Container(
                   padding: const EdgeInsets.all(12),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey.withOpacity(0.2)),
                     borderRadius: BorderRadius.circular(6),
                   ),
                   child: const Text('@radix-ui/colors', style: TextStyle(fontSize: 13)),
                ),
                 const Gap(8),
                Container(
                   padding: const EdgeInsets.all(12),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey.withOpacity(0.2)),
                     borderRadius: BorderRadius.circular(6),
                   ),
                   child: const Text('@stitches/react', style: TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
