import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DotListener extends StatelessWidget {
  final MyCarouselController control;
  final Widget Function(int index, int length, void Function(int) goToPage) builder;

  const DotListener({
    super.key,
    required this.control,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCarouselController>(
      id: MyCarouselController.dotListenerId,
      init: control,
      builder: (_) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 2000),
          child: builder(
            control.currentIndex,
            control.list.length,
            control.goToPage,
          ),
        );
      },
    );
  }
}

class MyCarouselController extends GetxController {
  static const String dotListenerId = 'dot_listener';

  List<dynamic> list = [];
  final PageController pageController = PageController();
  Duration? autoScrollDuration;
  Timer? _timer;
  int currentIndex = 0;

  @override
  void onInit() {
    super.onInit();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    if (autoScrollDuration == null || list.isEmpty) return;
    _timer = Timer.periodic(autoScrollDuration!, (_) {
      final nextIndex = (currentIndex + 1) % list.length;
      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void onPageChanged(int index) {
    currentIndex = index;
    update(); // Update carousel itself
    update([dotListenerId]); // Update DotListener specifically
  }

  void goToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}

class MyCarousel extends StatefulWidget {
  final MyCarouselController control;
  final List<Widget> items;
  final Duration? autoScrollDuration;

  const MyCarousel({
    super.key,
    required this.control,
    required this.items,
    this.autoScrollDuration,
  });

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  void initState() {
    super.initState();
    widget.control.list = widget.items;
    widget.control.autoScrollDuration = widget.autoScrollDuration;
    // No manual onInit
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCarouselController>(
      init: widget.control,
      builder: (_) {
        return SizedBox(
          height: 200,
          child: PageView.builder(
            controller: widget.control.pageController,
            itemCount: widget.items.length,
            onPageChanged: widget.control.onPageChanged,
            itemBuilder: (_, index) => widget.items[index],
          ),
        );
      },
    );
  }
}
