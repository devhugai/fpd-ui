/// Responsible for displaying documentation for Progress component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: progress.dart, component_page.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/progress.dart';
import '../../components/button.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  double _progress = 13;

  @override
  void initState() {
    super.initState();
    // Simulate progress loading
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _progress = 66);
    });
  }

  void _reset() {
    setState(() => _progress = 0);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _progress = 100);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Default Progress', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            FpduiProgress(value: _progress),
            const Gap(32),
            
            const Text('Controls', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Gap(16),
            Row(
              children: [
                FpduiButton(
                  text: '0%', 
                  variant: FpduiButtonVariant.outline,
                  onPressed: () => setState(() => _progress = 0)
                ),
                 const Gap(8),
                FpduiButton(
                  text: '50%', 
                   variant: FpduiButtonVariant.outline,
                  onPressed: () => setState(() => _progress = 50)
                ),
                 const Gap(8),
                FpduiButton(
                   text: '100%', 
                   variant: FpduiButtonVariant.outline,
                   onPressed: () => setState(() => _progress = 100)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
