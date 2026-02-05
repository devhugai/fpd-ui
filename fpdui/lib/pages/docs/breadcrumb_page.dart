/// Responsible for displaying documentation for Breadcrumb component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: breadcrumb.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/breadcrumb.dart';

class BreadcrumbPage extends StatelessWidget {
  const BreadcrumbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Breadcrumb')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Simple Breadcrumb', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            FpduiBreadcrumb(
              child: FpduiBreadcrumbList(
                children: [
                  FpduiBreadcrumbItem(
                    child: FpduiBreadcrumbLinkInteractive(
                      child: const Text('Home'),
                      onTap: () {},
                    ),
                  ),
                  const FpduiBreadcrumbSeparator(),
                  FpduiBreadcrumbItem(
                    child: FpduiBreadcrumbLinkInteractive(
                      child: const Text('Components'),
                      onTap: () {},
                    ),
                  ),
                  const FpduiBreadcrumbSeparator(),
                  const FpduiBreadcrumbItem(
                    child: FpduiBreadcrumbPage(
                      child: Text('Breadcrumb'),
                    ),
                  ),
                ],
              ),
            ),
             const SizedBox(height: 32),
             const Text('With Ellipsis', style: TextStyle(fontWeight: FontWeight.bold)),
             const SizedBox(height: 16),
              FpduiBreadcrumb(
              child: FpduiBreadcrumbList(
                children: [
                  FpduiBreadcrumbItem(
                    child: FpduiBreadcrumbLinkInteractive(
                      child: const Text('Home'),
                      onTap: () {},
                    ),
                  ),
                  const FpduiBreadcrumbSeparator(),
                  const FpduiBreadcrumbItem(
                    child: FpduiBreadcrumbEllipsis(),
                  ),
                  const FpduiBreadcrumbSeparator(),
                  FpduiBreadcrumbItem(
                    child: FpduiBreadcrumbLinkInteractive(
                      child: const Text('Components'),
                      onTap: () {},
                    ),
                  ),
                  const FpduiBreadcrumbSeparator(),
                   const FpduiBreadcrumbItem(
                    child: FpduiBreadcrumbPage(
                      child: Text('Breadcrumb'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
