import 'package:flutter/material.dart';
import '../../components/carousel.dart';
import '../../components/card.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carousel')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Carousel', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            
            // Example 1: Standard
            SizedBox(
              height: 200,
              width: 300,
              child: FpduiCarouselWrapper(
                child: Stack(
                  clipBehavior: Clip.none, // Allow buttons outside? hard in flutter default stack
                  alignment: Alignment.center,
                  children: [
                    FpduiCarouselContent(
                      children: List.generate(5, (index) {
                        return FpduiCarouselItem(
                          child: FpduiCard(
                             child: Center(child: Text("${index + 1}", style: const TextStyle(fontSize: 32))),
                          ),
                        );
                      }),
                    ),
                    const Positioned(
                      left: -20,
                      child: FpduiCarouselPrevious(),
                    ),
                    const Positioned(
                      right: -20,
                      child: FpduiCarouselNext(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 64),
            
            const Text('Multiple Items', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
             const SizedBox(height: 24),
             
             // Example 2: Fraction
            SizedBox(
              height: 150,
              child: FpduiCarouselWrapper(
                opts: const CarouselOptions(viewportFraction: 0.5),
                child: Row(
                  children: [
                    // To have buttons alongside content
                     const Padding(
                       padding: EdgeInsets.only(right: 8.0),
                       child: FpduiCarouselPrevious(),
                     ),
                    Expanded(
                      child: FpduiCarouselContent(
                        children: List.generate(10, (index) {
                          return FpduiCarouselItem(
                             child: Container(
                               color: Colors.grey[200],
                               alignment: Alignment.center,
                               child: Text("Item ${index + 1}"),
                             ),
                          );
                        }),
                      ),
                    ),
                     const Padding(
                       padding: EdgeInsets.only(left: 8.0),
                       child: FpduiCarouselNext(),
                     ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
