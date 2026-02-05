/// Responsible for displaying documentation for Tabs component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: tabs.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/tabs.dart';
import '../../components/card.dart';
import '../../components/button.dart';
import '../../components/label.dart';
import '../../components/input.dart';
import 'package:gap/gap.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tabs')),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FpduiTabs(
              width: 400,
              tabs: const ['Account', 'Password'],
              children: [
                const _AccountTabContent(),
                const _PasswordTabContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AccountTabContent extends StatelessWidget {
  const _AccountTabContent();

  @override
  Widget build(BuildContext context) {
    return FpduiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Ensure stretch for footer/header alignment
        mainAxisSize: MainAxisSize.min,
        children: [
          const FpduiCardHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FpduiCardTitle(child: Text('Account')),
                FpduiCardDescription(child: Text("Make changes to your account here. Click save when you're done.")),
              ],
            ),
          ),
          const FpduiCardContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FpduiLabel('Name'),
                Gap(8),
                FpduiInput(hintText: 'Pedro Duarte'),
                Gap(16),
                FpduiLabel('Username'),
                Gap(8),
                FpduiInput(hintText: '@peduarte'),
              ],
            ),
          ),
          FpduiCardFooter(
            child: FpduiButton(text: 'Save changes', onPressed: (){}),
          ),
        ],
      ),
    );
  }
}

class _PasswordTabContent extends StatelessWidget {
  const _PasswordTabContent();

  @override
  Widget build(BuildContext context) {
    return FpduiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const FpduiCardHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FpduiCardTitle(child: Text('Password')),
                FpduiCardDescription(child: Text("Change your password here. After saving, you'll be logged out.")),
              ],
            ),
          ),
          const FpduiCardContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FpduiLabel('Current password'),
                Gap(8),
                FpduiInput(obscureText: true),
                Gap(16),
                FpduiLabel('New password'),
                Gap(8),
                FpduiInput(obscureText: true),
              ],
            ),
          ),
          FpduiCardFooter(
             child: FpduiButton(text: 'Save password', onPressed: (){}),
          ),
        ],
      ),
    );
  }
}
