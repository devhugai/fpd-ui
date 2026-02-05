// Responsible for cycling through a series of content.
// Provides FpduiCarousel and FpduiCarouselContent.
//
// Used by: Image galleries, featured content.
// Depends on: carousel_slider (or custom implementation), fpdui_theme.
// Assumes: List of items to cycle through.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'button.dart';

class _CarouselScope extends InheritedWidget {
  const _CarouselScope({
    required this.controller,
    required this.canScrollPrev,
    required this.canScrollNext,
    required this.scrollPrev,
    required this.scrollNext,
    required super.child,
  });

  final PageController controller;
  final bool canScrollPrev;
  final bool canScrollNext;
  final VoidCallback scrollPrev;
  final VoidCallback scrollNext;

  static _CarouselScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_CarouselScope>();
  }

  @override
  bool updateShouldNotify(_CarouselScope oldWidget) {
    return controller != oldWidget.controller ||
        canScrollPrev != oldWidget.canScrollPrev ||
        canScrollNext != oldWidget.canScrollNext;
  }
}

class FpduiCarousel extends StatefulWidget {
  const FpduiCarousel({
    super.key,
    required this.content,
    this.previous,
    this.next,
    this.opts,
  });

  final Widget content;
  final Widget? previous;
  final Widget? next;
  final CarouselOptions? opts;

  @override
  State<FpduiCarousel> createState() => _FpduiCarouselState();
}

class CarouselOptions {
  final double viewportFraction;
  final bool loop;

  const CarouselOptions({
    this.viewportFraction = 1.0, 
    this.loop = false,
  });
}

class _FpduiCarouselState extends State<FpduiCarousel> {
  late PageController _controller;
  bool _canScrollPrev = false;
  bool _canScrollNext = true; // Assume true initially if items typically exist

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.opts?.viewportFraction ?? 1.0);
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients) return;
    
    // Simple check based on offset, exact logic depends on metrics
    final maxScroll = _controller.position.maxScrollExtent;
    final offset = _controller.offset;
    
    setState(() {
      _canScrollPrev = offset > 0;
      _canScrollNext = offset < maxScroll;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _scrollPrev() {
    _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollNext() {
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return _CarouselScope(
      controller: _controller,
      canScrollPrev: _canScrollPrev,
      canScrollNext: _canScrollNext,
      scrollPrev: _scrollPrev,
      scrollNext: _scrollNext,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
           // We place buttons outside content usually, but shadcn puts them absolute over content or changing flow.
           // Here we provide them as optional external widgets or user places them.
           // Wait, shadcn structure is:
           // Carousel -> CarouselContent -> CarouselItem
           // CarouselPrevious / CarouselNext are separate components placed inside Carousel.
           // So Carousel must be a Stack or Logic provider?
           // React Context usage allows them to be anywhere inside Carousel.
           // Flutter InheritedWidget does the same!
           
           // So FpduiCarousel simply wraps the child (which contains Content, Prev, Next arranged by user).
           // But here I defined `content`, `previous`, `next` as params? 
           // Better pattern: FpduiCarousel(child: Column/Row(...)) using context.
           
           // Let's refactor to pure wrapper.
           widget.content, // Actually, `widget.content` here acts as the `child` that contains everything?
           // The API design in `FpduiCarousel` constructor above implies specific structure.
           // Shadcn: <Carousel> <CarouselContent>...</CarouselContent> <CarouselPrevious /> <CarouselNext /> </Carousel>
           // In Flutter: FpduiCarousel( child: Stack( children: [ FpduiCarouselContent(...), Positioned(child: FpduiCarouselPrevious()) ] ) )
        ],
      ),
    );
  }
}

// Rewriting FpduiCarousel to be a wrapper only
class FpduiCarouselWrapper extends StatefulWidget {
  const FpduiCarouselWrapper({
    super.key,
    required this.child,
    this.opts,
    this.itemCount, // Needed to know boundaries? Or we rely on metrics listener
  });
  
  final Widget child;
  final CarouselOptions? opts;
  final int? itemCount;

  @override
  State<FpduiCarouselWrapper> createState() => _FpduiCarouselWrapperState();
}

class _FpduiCarouselWrapperState extends State<FpduiCarouselWrapper> {
  late PageController _controller;
  bool _canScrollPrev = false;
  bool _canScrollNext = true;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: widget.opts?.viewportFraction ?? 1.0);
    _controller.addListener(_onScroll);
  }
  
  void _onScroll() {
      if (!_controller.hasClients) return;
      final maxScroll = _controller.position.maxScrollExtent;
      final offset = _controller.offset;
      if (mounted) {
         final canPrev = offset > 0.1; // epsilon
         final canNext = offset < maxScroll - 0.1;
         if (canPrev != _canScrollPrev || canNext != _canScrollNext) {
             setState(() {
                _canScrollPrev = canPrev;
                _canScrollNext = canNext;
             });
         }
      }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _scrollPrev() {
    _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _scrollNext() {
    _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  
  @override
  Widget build(BuildContext context) {
    return _CarouselScope(
      controller: _controller,
      canScrollPrev: _canScrollPrev,
      canScrollNext: _canScrollNext,
      scrollPrev: _scrollPrev,
      scrollNext: _scrollNext,
      child: widget.child,
    );
  }
}

class FpduiCarouselContent extends StatelessWidget {
  const FpduiCarouselContent({super.key, required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final scope = _CarouselScope.of(context);
    if (scope == null) return const SizedBox();
    
    // CarouselContent holds the PageView
    return PageView(
      controller: scope.controller,
      physics: const BouncingScrollPhysics(), // or Clamping to match web feel?
      children: children,
    );
  }
}

class FpduiCarouselItem extends StatelessWidget {
  const FpduiCarouselItem({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Just a container, maybe padding?
    // Shadcn: pl-4 basis-full etc.
    // In PageView, resizing is handled by viewportFraction.
    // We add padding to simulate gap.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4), // gap simulation
      child: child,
    );
  }
}

class FpduiCarouselPrevious extends StatelessWidget {
  const FpduiCarouselPrevious({super.key, this.variant = FpduiButtonVariant.outline});
  final FpduiButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final scope = _CarouselScope.of(context);
    
    return FpduiButton(
      variant: variant,
      size: FpduiButtonSize.icon,
      onPressed: (scope != null && scope.canScrollPrev) ? scope.scrollPrev : null,
      child: const Icon(LucideIcons.arrowLeft, size: 16),
      // Rounded full usually?
    );
  }
}

class FpduiCarouselNext extends StatelessWidget {
  const FpduiCarouselNext({super.key, this.variant = FpduiButtonVariant.outline});
  final FpduiButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final scope = _CarouselScope.of(context);

    return FpduiButton(
      variant: variant,
      size: FpduiButtonSize.icon,
      onPressed: (scope != null && scope.canScrollNext) ? scope.scrollNext : null,
      child: const Icon(LucideIcons.arrowRight, size: 16),
    );
  }
}
