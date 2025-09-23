import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/routes/routers.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/features/search/main/search_section_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {


  final control = SearchSectionControl();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      control.onInit();
    },);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              const SizedBox(height: 1,),
              AnimButton(
                onClick: control.onSearchClick,
                child: Container(
                  decoration: Decorations.card,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(child: Text("Search")),
                      SvgIcon(path: "ic_search", color: AppColors.primary,)
                    ],
                  ),
                ),
              ),
              Obx(() {
                final list = control.brandsList;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  children: List.generate(
                    list.length, (index) =>
                      AnimButton(
                        onClick: () => navigate(list[index].route),
                        child: ImageLoader(url: list[index].image
                            .autoUrl,
                          height: 140,),
                      ),),
                );
              }),
              const SizedBox(height: 16,),
            ],
          ),
        ))
      ],
    );
  }
}
