import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/features/home/models/category_model.dart';
import 'package:error_fit/features/home/section/home_section_controller.dart';
import 'package:flutter/material.dart';

import '../../../config/styles/app_colors.dart';
import '../../../core/app_bars/main_app_bar.dart';
import '../../../core/images/ImageLoader.dart';
import '../../../core/resources/constants.dart';
import '../../../core/widgets/my_carousel.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final control = HomeSectionController();

  @override
  void initState() {
    control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _carousel(),
                const SizedBox(height: 26),
                _categories(),
                const SizedBox(height: 26),
                ImageLoader(
                  url: dummyImages[2].autoUrl,
                  height: 200,
                  radius: 0,
                ),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
        Positioned(left: 0,
            right: 0,
            top: 0,
            child: MainAppBar(background: AppColors.transparent,)),
      ],
    );
  }

  Widget _carousel() {
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          Positioned.fill(
            child: MyCarousel(
              control: control.carouselControl,
              autoScrollDuration: Duration(seconds: 3),
              items: [
                ImageLoader(
                  url: dummyImages[1].autoUrl,
                  radius: 0,
                ),
                ImageLoader(
                  url: dummyImages[1].autoUrl,
                  radius: 0,
                ),
                ImageLoader(
                  url: dummyImages[1].autoUrl,
                  radius: 0,
                ),
                ImageLoader(
                  url: dummyImages[1].autoUrl,
                  radius: 0,
                ),
                ImageLoader(
                  url: dummyImages[1].autoUrl,
                  radius: 0,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: DotListener(
                control: control.carouselControl,
                builder: (index, length, goToPage) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.black.withAlpha(100),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        length,
                        (i) => Container(
                          width: index == i ? 24 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            color: AppColors.white,
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 4,
                          ),
                        ),
                        // Text(" O ",
                        //   style: TextStyle(color: index == i ? Colors
                        //       .white : Colors.black),),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          spacing: 16,
          children: CategoryModel.dummyList
              .map((e) => _categoryTile(model: e))
              .toList(),
        ),
      ),
    );
  }

  Widget _categoryTile({required CategoryModel model}) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageLoader(
              url: model.image.autoUrl, radius: 48, height: 140, width: 100),
          const SizedBox(height: 12),
          Text(model.title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
