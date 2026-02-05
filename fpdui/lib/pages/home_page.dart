/// Responsible for the landing page view.
/// Provides entry point buttons to docs and sink.
///
/// Used by: Root route ('/').
/// Depends on: fpdui components.
/// Assumes: Marketing-style layout.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../components/button.dart';
import '../theme/theme_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
