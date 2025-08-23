import 'package:flutter/material.dart';

import '../../../core/buttons/button.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: Column(children: [])),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Clear"),
              Button(onClick: onFilterApplyClick, text: "Apply"),
            ],
          ),
        ),
      ],
    );
  }

  void onFilterApplyClick() {}
}
