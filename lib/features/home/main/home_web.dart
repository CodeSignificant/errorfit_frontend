import 'package:error_fit/config/extensions/num_extentions.dart';
import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/core/app_bars/footer.dart';
import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/resources/center_max.dart';
import 'package:error_fit/features/home/main/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/routes/routers.dart';
import '../../../config/services/auth.dart';
import '../../../config/styles/app_colors.dart';
import '../../../config/styles/font_styles.dart';
import '../../../core/buttons/anim_button.dart';
import '../../../core/images/ImageLoader.dart';
import '../../../core/widgets/my_carousel.dart';
import '../../products/widgets/product_tile.dart';
import '../models/home_flow_model.dart';

class HomeWeb extends StatefulWidget {
  final HomeController control;

  const HomeWeb({super.key, required this.control});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {

  @override
  void initState() {
    if(Auth.isLogin){
      widget.control.loadRecentlyViewedProducts();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainAppBar(),
      Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CenterMax(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        _carousel(),
                        const SizedBox(height: 60),
                        Obx(() {
                          final flow = widget.control.homeFlowList.value;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 70,
                            children: List.generate(
                              flow.length, (index) =>
                                _generateFlow(flow[index]),),
                          );
                        }),
                        _recentlyViewed(),
                      ],)),
                const SizedBox(height: 60,),
                Footer()
              ],
            ),))
    ]);
  }


  Widget _carousel() {
    return SizedBox(
      height: 600.ratio(context, 250, 600),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: MyCarousel<MyCarouselModel>(
                control: widget.control.carouselControl,
                autoScrollDuration: Duration(seconds: 3),
                builder: (index, length, item) =>
                    GestureDetector(
                        onTap: () => widget.control.onCarouselItemClick(item),
                        child: ImageLoader(
                          url: (item as MyCarouselModel).image.autoUrl,
                        )),
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
                  control: widget.control.carouselControl,
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
      ),
    );
  }

  Widget _categories(List<CategoryFlowModel> categories) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
      onClick: () => widget.control.onCategoryClick(model),
      child: SizedBox(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageLoader(
                url: model.image.autoUrl, radius: 100, height: 200),
            const SizedBox(height: 12),
            Text(model.title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _horizontalImages(List<HorizontalImagesFlowModel> categories) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories
              .map((e) =>
              AnimButton(onClick: () => navigate(e.route),
                  child: ImageLoader(
                    url: e.image.autoUrl,
                    radius: 0,
                    height: 250,
                    width: 200,
                    fit: BoxFit.cover,)))
              .toList(),
        ),
      ),
    );
  }

  Widget _adImage({required AdImageFlowModel model}) {
    return AnimButton(
        onClick: () {
          navigate(model.route);
        },
        child: ImageLoader(url: model.image.autoUrl,
          height: 500,
          radius: 0,));
  }


  Widget _recentlyViewed() {
    return Obx(() {
      final list = widget.control.recentlyViewedProducts.value;
      if(list.isEmpty){
        return SizedBox();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                        onClick: widget.control.onProductClick,
                        onLikeClick: widget.control.onProductLikeClick),),
              ),
            ),
          )
        ],
      );
    });
  }

  Widget _grid2Add(List<Grid2FlowModel> model) {
    return SizedBox(
      height: 500.ratio(context, 400, 500),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
      height: 500.ratio(context, 400, 500),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: AnimButton(
                  onClick: () => navigate(model.first.route),
                  child: ImageLoader(
                    url: model.first.image.autoUrl,
                    radius: 0,
                    fit: BoxFit.cover,))),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: AnimButton(
                        onClick: () => navigate(model[1].route),
                        child: ImageLoader(
                          url: model[1].image.autoUrl,
                          radius: 0, fit: BoxFit.cover,),
                      )),
                  Expanded(
                      child: AnimButton(
                        onClick: () => navigate(model[2].route),
                        child: ImageLoader(
                          url: model[2].image.autoUrl,
                          radius: 0, fit: BoxFit.cover,),
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
