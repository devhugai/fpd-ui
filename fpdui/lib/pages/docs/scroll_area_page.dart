import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/scroll_area.dart';
import '../../components/separator.dart';

class ScrollAreaPage extends StatelessWidget {
  const ScrollAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tags = List.generate(50, (index) => 'v1.2.0-beta.$index');

    return Scaffold(
      appBar: AppBar(title: const Text('ScrollArea')),
      body: Center(
        child: Container(
          height: 200, // h-72 is approx 288px, let's use 200 for demo
          width: 350,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)), // rounded-md border
            borderRadius: BorderRadius.circular(6),
          ),
          child: FpduiScrollArea(
             child: Padding(
               padding: const EdgeInsets.all(16.0), // p-4
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text(
                     'Tags',
                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600), // mb-4 text-sm font-medium leading-none
                   ),
                   const Gap(16),
                   ...tags.map((tag) => Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       Text(
                         tag,
                         style: const TextStyle(fontSize: 14), // text-sm
                       ),
                       const Gap(8), // my-2
                       const FpduiSeparator(),
                       const Gap(8), // my-2
                     ],
                   )),
                 ],
               ),
             ),
          ),
        ),
      ),
    );
  }
}
