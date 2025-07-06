import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/styles/app_colors.dart';
import '../images/ImageLoader.dart';

class CarouselModel {
  final String image;
  final String id;
  final dynamic model;

  CarouselModel({required this.image, required this.id, this.model});
}

class Carousel extends StatefulWidget {
  final List<CarouselModel> list;
  final Function(CarouselModel carousel) onClick;
  final double? dotBottom;

  const Carousel({
    super.key,
    required this.list,
    required this.onClick,
    this.dotBottom,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final PageController _pageController = PageController();
  late Timer _timer;
  RxInt _activeIndex = 0.obs;
  List<dynamic> selectedImages = [];

  @override
  void initState() {
    _startAutoScroll();
    super.initState();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_activeIndex < widget.list.length - 1) {
        _activeIndex++;
      } else {
        _activeIndex.value = 0;
      }
      _pageController.animateToPage(
        _activeIndex.value,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChange,
            children: List.generate(
              widget.list.length,
              (index) => _sliderTile(widget.list[index]),
            ),
          ),
        ),
        Positioned(
          bottom: widget.dotBottom ?? 22,
          left: 16,
          right: 16,
          child: _dotsIndicator(),
        ),
      ],
    );
  }

  void _onPageChange(int value) {
    _activeIndex.value = value;
  }

  _sliderTile(CarouselModel item) {
    if (!(item.image.startsWith("http"))) {
      return GestureDetector(
        onTap: () => widget.onClick(item),
        child: Image.asset("assets/images/${item.image}", fit: BoxFit.fill),
      );
    }
    return GestureDetector(
      onTap: () => widget.onClick(item),
      child: ImageLoader(
        url: item.image,
        alt: item.image,
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }

  Widget _dotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.black.withAlpha(20),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(4),
          child: Obx(() {
            final activeIndex = _activeIndex.value;
            return Row(
              children: List.generate(widget.list.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color:
                        index == activeIndex ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                );
              }),
            );
          }),
        ),
      ],
    );
  }
}
