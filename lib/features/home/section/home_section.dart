import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/features/home/models/home_flow_model.dart';
import 'package:error_fit/features/home/section/home_section_controller.dart';
import 'package:error_fit/features/products/widgets/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/styles/app_colors.dart';
import '../../../core/app_bars/main_app_bar.dart';
import '../../../core/images/ImageLoader.dart';
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
            controller: control.scrollControl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _carousel(),
                const SizedBox(height: 26),
                Obx(() {
                  final flow = control.homeFlowList.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 26,
                    children: List.generate(
                      flow.length, (index) => _generateFlow(flow[index]),),
                  );
                }),
                // _categories([]),
                // const SizedBox(height: 26),
                // ImageLoader(
                //   url: dummyImages[2].autoUrl,
                //   height: 200,
                //   radius: 0,
                // ),
                // const SizedBox(height: 26),
                // // _grid3Add([]),
                // const SizedBox(height: 26),
                // ImageLoader(
                //   url: dummyImages[2].autoUrl,
                //   height: 200,
                //   radius: 0,
                // ),
                // const SizedBox(height: 26),
                // // _grid2Add(),
                // const SizedBox(height: 26),
                // ImageLoader(
                //   url: dummyImages[2].autoUrl,
                //   height: 200,
                //   radius: 0,
                // ),
                // const SizedBox(height: 26),
                _recentlyViewed(),
                // const SizedBox(height: 26),
                // ImageLoader(
                //   url: dummyImages[2].autoUrl,
                //   height: 200,
                //   radius: 0,
                // ),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
        Positioned(left: 0,
            right: 0,
            top: 0,
            child: Obx(() {
              return MainAppBar(
                background: control.showAppbarBackground.value ? AppColors
                    .white : AppColors.transparent,);
            })),
      ],
    );
  }

  Widget _carousel() {
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          Positioned.fill(
            child: MyCarousel<MyCarouselModel>(
              control: control.carouselControl,
              autoScrollDuration: Duration(seconds: 3),
              builder: (index, length, item) =>
                  GestureDetector(
                      onTap: () => control.onCarouselItemClick(item),
                      child: ImageLoader(
                        url: (item as MyCarouselModel).image.autoUrl,
                        radius: 0,)),
              // items: [
              //   ImageLoader(
              //     url: dummyImages[1].autoUrl,
              //     radius: 0,
              //   ),
              //   ImageLoader(
              //     url: dummyImages[1].autoUrl,
              //     radius: 0,
              //   ),
              //   ImageLoader(
              //     url: dummyImages[1].autoUrl,
              //     radius: 0,
              //   ),
              //   ImageLoader(
              //     url: dummyImages[1].autoUrl,
              //     radius: 0,
              //   ),
              //   ImageLoader(
              //     url: dummyImages[1].autoUrl,
              //     radius: 0,
              //   ),
              // ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: DotListener(
                control: control.carouselControl,
                builder: (index, length, goToPage) =>
                    Container(
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
                                (i) =>
                                Container(
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

  Widget _categories(List<CategoryFlowModel> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          spacing: 16,
          children: categories
              .map((e) => _categoryTile(model: e))
              .toList(),
        ),
      ),
    );
  }


  Widget _categoryTile({required CategoryFlowModel model}) {
    return AnimButton(
      onClick: () => control.onCategoryClick(model),
      child: SizedBox(
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
      ),
    );
  }

  Widget _horizontalImages(List<HorizontalImagesFlowModel> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map((e) =>
            AnimButton(onClick: () => navigate(e.route),
                child: ImageLoader(
                  url: e.image.autoUrl,
                  radius: 0,
                  height: 200,
                  width: 150,
                  fit: BoxFit.cover,)))
            .toList(),
      ),
    );
  }

  Widget _adImage({required AdImageFlowModel model}) {
    return AnimButton(
        onClick: () {
          navigate(model.route);
        },
        child: ImageLoader(url: model.image.autoUrl,
          height: 200,
          radius: 0,));
  }

  Widget _recentlyViewed() {
    return Obx(() {
      final list = control.recentlyViewedProducts;
      if(list.isEmpty){
        return SizedBox();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text("Recently Viewed", style: FontStyles.s16Primary7,),
          ),
          const SizedBox(height: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                spacing: 10,
                children: List.generate(list.length, (index) =>
                    ProductTile(model: list[index],
                        onClick: control.onProductClick,
                        onLikeClick: control.onProductLikeClick),),
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _grid2Add(List<Grid2FlowModel> model) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(child: AnimButton(onClick: () => navigate(model.first.route),
              child: ImageLoader(url: model.first.image.autoUrl, radius: 0,))),
          Expanded(
              child: AnimButton(onClick: () => navigate(model.last.route),
                  child: ImageLoader(
                    url: model.last.image.autoUrl, radius: 0,)))
        ],
      ),
    );
  }

  Widget _grid3Add(List<Grid3FlowModel> model) {
    return SizedBox(
      height: 200,
      child: Row(
        children: [
          Expanded(child: AnimButton(onClick: () => navigate(model.first.route),
              child: ImageLoader(url: model.first.image.autoUrl, radius: 0,))),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: AnimButton(
                onClick: () => navigate(model[1].route),
                child: ImageLoader(
                  url: model[1].image.autoUrl,
                  radius: 0,),
              )),
              Expanded(child: AnimButton(
                onClick: () => navigate(model[2].route),
                child: ImageLoader(
                  url: model[2].image.autoUrl,
                  radius: 0,),
              )),
            ],
          ))
        ],
      ),
    );
  }

  Widget _generateFlow(flow) {
    if (flow['type'] == "categories") {
      return _categories(CategoryFlowModel.fromJsonList(flow['data'] ?? []));
    }
    if (flow['type'] == "banner") {
      return _adImage(model: AdImageFlowModel.fromJson(flow['data'] ?? {}));
    }

    if (flow['type'] == "horizontal_images") {
      return _horizontalImages(
          HorizontalImagesFlowModel.fromJsonList(flow['data'] ?? []));
    }
    if (flow['type'] == "grid3") {
      List<Grid3FlowModel> output = [];
      final list = Grid3FlowModel.fromJsonList(flow['data'] ?? []);
      for (int i = 0; i < 3; i++) {
        try {
          output.add(list[i]);
        } catch (e) {
          output.add(Grid3FlowModel.fromJson({}));
        }
      }
      return _grid3Add(output);
    }

    if (flow['type'] == "grid2") {
      List<Grid2FlowModel> output = [];
      final list = Grid2FlowModel.fromJsonList(flow['data'] ?? []);
      for (int i = 0; i < 2; i++) {
        try {
          output.add(list[i]);
        } catch (e) {
          output.add(Grid2FlowModel.fromJson({}));
        }
      }
      return _grid2Add(output);
    }
    return SizedBox();
  }
}
