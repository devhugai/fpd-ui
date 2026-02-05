/// Responsible for displaying documentation for Pagination component.
/// Provides usage examples and API details.
///
/// Used by: Router.
/// Depends on: pagination.dart, component_page.
import 'package:flutter/material.dart';
import '../../components/pagination.dart';
import 'component_page.dart';

class PaginationPage extends StatefulWidget {
  const PaginationPage({super.key});

  @override
  State<PaginationPage> createState() => _PaginationPageState();
}

class _PaginationPageState extends State<PaginationPage> {
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'Pagination',
      description: 'Pagination with page navigation, next and previous links.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FpduiPagination(
            currentPage: _currentPage,
            totalPages: 10,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
        ],
      ),
    );
  }
}
