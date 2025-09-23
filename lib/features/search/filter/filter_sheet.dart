import 'package:flutter/material.dart';

import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/core/widgets/sheet_nob.dart';
import 'package:error_fit/features/search/filter/filter_view.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: Decorations.sheet,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          SizedBox(height: 16),
          SheetNob(),
          SizedBox(height: 16),
          Expanded(child: FilterView()),
        ],
      ),
    );
  }
}