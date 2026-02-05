/// Responsible for resizable panel layouts.
/// Provides FpduiResizablePanelGroup and FpduiResizablePanel.
///
/// Used by: IDE-like layouts, split views.
/// Depends on: fpdui_theme, flutter_resizable_container (or custom logic).
/// Assumes: Parent constraints allowed resizing.
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/fpdui_theme.dart';

enum FpduiResizableDirection { horizontal, vertical }

class FpduiResizablePanelGroup extends StatefulWidget {
  const FpduiResizablePanelGroup({
    super.key,
    required this.direction,
    required this.children,
    this.initialSizes, // Initial relative sizes (e.g., [0.5, 0.5])
  });

  final FpduiResizableDirection direction;
  final List<Widget> children;
  final List<double>? initialSizes; // Fractional sizes summing to 1.0

  @override
  State<FpduiResizablePanelGroup> createState() => _FpduiResizablePanelGroupState();
}

class _FpduiResizablePanelGroupState extends State<FpduiResizablePanelGroup> {
  late List<double> _sizes;
  
  // Flattened list of widgets: Panel, Handle, Panel, Handle, Panel...
  // But wait, children layout is strict. 
  // API design: The children passed here are Panels. The Handles are usually interspersed manually or valid automatically?
  // shadcn: <ResizablePanelGroup> <ResizablePanel> ... </ResizablePanel> <ResizableHandle /> <ResizablePanel> ... </ResizablePanel> </ResizablePanelGroup>
  // In Flutter, strict children list is easier if we manage handles internally OR explicit Handle widgets in list.
  // shadcn API explicitly inserts handles.
  // Let's support explicit handles for maximum flexibility (nesting handled via recursive groups).
  
  // Problem: Explicit handles in a list mean we need to detect which widgets are panels and which are handles to manage layout.
  // Let's assume `children` contains everything.
  // But we need to manage flex values.
  
  // Simplified Approach for this MVP:
  // The group manages layout. If we see a "Handle" widget, it becomes a drag target.
  // We need to maintain a state of "sizes" for the PANELS.
  
  // Let's try to interpret the children.
  // Index of panels vs handles.
  
  @override
  void initState() {
    super.initState();
    _initSizes();
  }
  
  void _initSizes() {
    // Count panels
    int panels = widget.children.whereType<FpduiResizablePanel>().length;
    if (widget.initialSizes != null && widget.initialSizes!.length == panels) {
      _sizes = List.from(widget.initialSizes!);
    } else {
      _sizes = List.filled(panels, 1.0 / panels);
    }
  }

  void _onResize(int panelIndex, double deltaPx, double availableSpace) {
    // Resize panel at panelIndex and panelIndex+1
    // deltaPx is positive if moving right/down (increasing panelIndex size, decreasing next)
    
    // availableSpace is strictly the space for PANELS (excluding handles).
        
    double deltaFrac = deltaPx / availableSpace;
    
    // Check bounds
    // We strictly resize _sizes[panelIndex] and decrease _sizes[panelIndex+1]
    
    setState(() {
      double newSizeA = _sizes[panelIndex] + deltaFrac;
      double newSizeB = _sizes[panelIndex + 1] - deltaFrac;
      
      // Basic clamping (min 5% size)
      if (newSizeA >= 0.05 && newSizeB >= 0.05) {
        _sizes[panelIndex] = newSizeA;
        _sizes[panelIndex + 1] = newSizeB;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int panelIndex = 0;
        List<Widget> layoutChildren = [];
        
        // Calculate available space for panels
        int handleCount = widget.children.whereType<FpduiResizableHandle>().length;
        double totalSpace = widget.direction == FpduiResizableDirection.horizontal 
            ? constraints.maxWidth 
            : constraints.maxHeight;
        double handleSpace = handleCount * 10.0; // 10.0 is handle size
        double availableSpace = totalSpace - handleSpace;
        
        if (availableSpace < 0) availableSpace = 0;
        
        for (var i = 0; i < widget.children.length; i++) {
          final child = widget.children[i];
          
          if (child is FpduiResizablePanel) {
            final size = _sizes[panelIndex];
            layoutChildren.add(
              SizedBox(
                width: widget.direction == FpduiResizableDirection.horizontal 
                    ? availableSpace * size 
                    : constraints.maxWidth, // Full width in vertical
                height: widget.direction == FpduiResizableDirection.vertical 
                    ? availableSpace * size 
                    : constraints.maxHeight, // Full height in horizontal
                child: child,
              )
            );
            panelIndex++;
          } else if (child is FpduiResizableHandle) {
             final controlledPanelIndex = panelIndex - 1;
             
             layoutChildren.add(
               GestureDetector(
                 behavior: HitTestBehavior.translucent,
                 onHorizontalDragUpdate: widget.direction == FpduiResizableDirection.horizontal 
                    ? (details) => _onResize(controlledPanelIndex, details.delta.dx, availableSpace) // Pass availableSpace
                    : null,
                 onVerticalDragUpdate: widget.direction == FpduiResizableDirection.vertical 
                    ? (details) => _onResize(controlledPanelIndex, details.delta.dy, availableSpace) // Pass availableSpace
                    : null,
                 child: MouseRegion(
                   cursor: widget.direction == FpduiResizableDirection.horizontal 
                      ? SystemMouseCursors.resizeColumn 
                      : SystemMouseCursors.resizeRow,
                   child: child, // Handle itself is fixed 10px
                 ),
               )
             );
          } else {
             layoutChildren.add(child);
          }
        }
        
        return Flex(
          direction: widget.direction == FpduiResizableDirection.horizontal 
              ? Axis.horizontal 
              : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: layoutChildren,
        );
      },
    );
  }
}

class FpduiResizablePanel extends StatelessWidget {
  const FpduiResizablePanel({
    super.key,
    required this.child,
    this.defaultSize,
    this.minSize,
    this.maxSize,
  });

  final Widget child;
  final double? defaultSize; // Not used in this simplified impl yet, managed by Group
  final double? minSize;
  final double? maxSize;

  @override
  Widget build(BuildContext context) {
    return ClipRect(child: child); // Clip content
  }
}

class FpduiResizableHandle extends StatelessWidget {
  const FpduiResizableHandle({
    super.key,
    this.withHandle = false,
  });
  
  final bool withHandle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fpduiTheme = theme.extension<FpduiTheme>()!;
    
    // shadcn visual: thin 1px border like, 5px touch target? No, typically visible width/height is small.
    // "h-1.5 w-full bg-border" etc. or w-px.
    // Let's check shadcn implementation source if possible, but standard is "w-px bg-border" for vertical split.
    
    // We want a slightly larger touch area than visual area.
    
    return Container(
      color: Colors.transparent, // Touch target
      width: 10, // Touch width (if horizontal)
      height: 10, // Touch height (if vertical)
      alignment: Alignment.center,
      child: Container(
        color: fpduiTheme.border,
        width: 1, // Visual width
        height: double.infinity,
        child: withHandle 
            ? Center(
                child: Container(
                  width: 4, height: 16, // Tiny handle pill
                  decoration: BoxDecoration(
                    color: fpduiTheme.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Icon(LucideIcons.gripVertical, size: 8, color: fpduiTheme.mutedForeground), 
                  // or just visual grip logic
                ),
              )
            : null,
      ),
    );
  }
}
