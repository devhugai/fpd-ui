import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../components/avatar.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sizes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const Wrap(
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                FpduiAvatar(
                  size: FpduiAvatarSize.lg,
                  image: NetworkImage('https://github.com/shadcn.png'),
                  fallback: Text('CN'),
                ),
                FpduiAvatar(
                  size: FpduiAvatarSize.$default,
                  image: NetworkImage('https://github.com/shadcn.png'),
                  fallback: Text('CN'),
                ),
                FpduiAvatar(
                  size: FpduiAvatarSize.sm,
                  image: NetworkImage('https://github.com/shadcn.png'),
                  fallback: Text('CN'),
                ),
              ],
            ),
            const Gap(32),
            const Text('Fallbacks', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const Wrap(
              spacing: 16,
              children: [
                 FpduiAvatar(
                  size: FpduiAvatarSize.lg,
                  fallback: Text('CN'),
                ),
                 FpduiAvatar(
                  size: FpduiAvatarSize.$default,
                  fallback: Text('JD'),
                ),
                 FpduiAvatar(
                  size: FpduiAvatarSize.sm,
                  fallback: Text('S'),
                ),
              ],
            ),
             const Gap(32),
            const Text('Broken Image', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Gap(16),
            const Wrap(
              spacing: 16,
              children: [
                 FpduiAvatar(
                  size: FpduiAvatarSize.$default,
                  image: NetworkImage('https://invalid-url.png'),
                  fallback: Text('ER'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
