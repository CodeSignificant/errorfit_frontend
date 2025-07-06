import 'package:error_fit/features/home/main/home_controller.dart';
import 'package:flutter/material.dart';
class HomeTab extends StatefulWidget {
  final HomeController control;
  const HomeTab({super.key, required this.control});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
