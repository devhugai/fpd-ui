import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/skeleton.dart';

class SkeletonPage extends StatelessWidget {
  const SkeletonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skeleton')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Profile Example', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            Row(
              children: [
                 const FpduiSkeleton(
                    width: 40,
                    height: 40,
                    shape: BoxShape.circle,
                 ),
                 const Gap(12),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      const FpduiSkeleton(width: 200, height: 16),
                      const Gap(4),
                      const FpduiSkeleton(width: 150, height: 14),
                   ],
                 ),
              ],
            ),
             const Gap(32),
             const Text('Card Example', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
             const Gap(16),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const FpduiSkeleton(
                    width: double.infinity,
                    height: 150,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                 ),
                 const Gap(16),
                 const FpduiSkeleton(width: 200, height: 20),
                 const Gap(8),
                 const FpduiSkeleton(width: double.infinity, height: 16),
                 const Gap(4),
                 const FpduiSkeleton(width: 100, height: 16),
               ],
             ),
          ],
        ),
      ),
    );
  }
}
