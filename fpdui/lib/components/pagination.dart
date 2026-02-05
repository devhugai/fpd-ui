// Responsible for page navigation controls.
// Provides FpduiPagination widget.
//
// Used by: DataTables, Lists.
// Depends on: fpdui_theme, button.dart.
// Assumes: 1-based indexing.
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'button.dart';

class FpduiPagination extends StatelessWidget {
  const FpduiPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.siblingCount = 1,
  });

  /// The current active page (1-based).
  final int currentPage;

  /// Total number of pages.
  final int totalPages;

  /// Callback when a page is selected.
  final ValueChanged<int> onPageChanged;

  /// Number of pages to show on each side of current page.
  final int siblingCount;

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous Button
        FpduiButton(
          variant: FpduiButtonVariant.ghost,
          size: FpduiButtonSize.sm,
          onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
          child: Row(
            children: const [
              Icon(LucideIcons.chevronLeft, size: 16),
              Gap(4),
              Text('Previous'),
            ],
          ),
        ),
        
        const Gap(8),
        
        // Page Numbers
        ..._buildPageNumbers(context),
        
        const Gap(8),
        
        // Next Button
        FpduiButton(
          variant: FpduiButtonVariant.ghost,
          size: FpduiButtonSize.sm,
          onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
          child: Row(
            children: const [
              Text('Next'),
              Gap(4),
              Icon(LucideIcons.chevronRight, size: 16),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPageNumbers(BuildContext context) {
    final items = <Widget>[];

    // Logic to calculate range
    // Always show first, last, current, and siblings.
    // Use ellipsis (...) for gaps.

    // Range start/end
    final int leftSiblingIndex = (currentPage - siblingCount).clamp(1, totalPages);
    // final int rightSiblingIndex = (currentPage + siblingCount).clamp(1, totalPages); // Unused

    final bool showLeftEllipsis = leftSiblingIndex > 2;
    // final bool showRightEllipsis = rightSiblingIndex < totalPages - 1; // Unused

    // First Page
    if (leftSiblingIndex > 1) {
       items.add(_PaginationItem(
         page: 1, 
         isActive: currentPage == 1, 
         onTap: () => onPageChanged(1),
       ));
    }

    // Left Ellipsis
    if (showLeftEllipsis) {
      items.add(_PaginationEllipsis());
    }

    // Siblings + Current
    // Ensure we at least show 1 if logic above skipped it (e.g. current=1)
    // Range around current
    // If current is near start (e.g. 1, 2, 3), show 2, 3...
    // This logic is tricky to get perfect standard shadcn feel.
    // Standard approach: 1 ... 4 5 6 ... 10
    
    // Let's use specific logic:
    // 1
    // ...
    // current - 1
    // current
    // current + 1
    // ...
    // last
    
    // We already handled cases <= 7 pages.
    
    // Middle pages
    // We need to deduplicate.
    
    final Set<int> pagesToShow = {1, totalPages};
    if (currentPage > 1 && currentPage < totalPages) pagesToShow.add(currentPage);
    if (currentPage - 1 > 1) pagesToShow.add(currentPage - 1);
    if (currentPage + 1 < totalPages) pagesToShow.add(currentPage + 1);
    
    // Add more if near edges to keep constant width?
    // If current is 1, show 1, 2, 3 ... last
    if (currentPage == 1) { pagesToShow.add(2); pagesToShow.add(3); }
    if (currentPage == totalPages) { pagesToShow.add(totalPages - 1); pagesToShow.add(totalPages - 2); }

    final sortedPages = pagesToShow.toList()..sort();
    
    // Build list with ellipsis
    int lastPage = 0;
    for (final page in sortedPages) {
      if (lastPage != 0 && page - lastPage > 1) {
        items.add(_PaginationEllipsis());
      }
      items.add(_PaginationItem(
        page: page,
        isActive: page == currentPage,
        onTap: () => onPageChanged(page),
      ));
      lastPage = page;
    }
    
    return items;
  }
}

class _PaginationItem extends StatelessWidget {
  const _PaginationItem({
    required this.page,
    required this.isActive,
    required this.onTap,
  });

  final int page;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FpduiButton(
      variant: isActive ? FpduiButtonVariant.outline : FpduiButtonVariant.ghost,
      size: FpduiButtonSize.icon,
      onPressed: onTap,
       // If active, maybe highlight stronger? Shadcn uses Outline for active page pagination usually.
      child: Text(page.toString()),
    );
  }
}

class _PaginationEllipsis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 32,
      height: 32,
      child: Center(child: Text('...')),
    );
  }
}
