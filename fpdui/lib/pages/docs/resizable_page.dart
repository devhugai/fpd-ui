/// Responsible for displaying documentation for Resizable component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: resizable.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/resizable.dart';

class ResizablePage extends StatelessWidget {
  const ResizablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resizable')),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Container(
            height: 400,
            width: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FpduiResizablePanelGroup(
                direction: FpduiResizableDirection.horizontal,
                children: [
                  FpduiResizablePanel(
                    child: Container(
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: const Text('One'),
                    ),
                  ),
                  const FpduiResizableHandle(),
                  FpduiResizablePanel(
                    child: FpduiResizablePanelGroup(
                       direction: FpduiResizableDirection.vertical,
                       children: [
                          FpduiResizablePanel(
                             child: Container(
                               color: Colors.white,
                               alignment: Alignment.center,
                               child: const Text('Two'),
                             ),
                          ),
                          const FpduiResizableHandle(withHandle: true), // With visual handle demo
                          FpduiResizablePanel(
                             child: Container(
                               color: Colors.white,
                               alignment: Alignment.center,
                               child: const Text('Three'),
                             ),
                          ),
                       ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
