import 'package:error_fit/config/extensions/string_extensions.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/config/styles/decorations.dart';
import 'package:error_fit/config/styles/font_styles.dart';
import 'package:error_fit/core/app_bars/main_app_bar.dart';
import 'package:error_fit/core/buttons/anim_button.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/core/images/svg_icon.dart';
import 'package:error_fit/core/resources/constants.dart';
import 'package:error_fit/features/search/main/search_section_control.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {


  final control = SearchSectionControl();


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MainAppBar(),
        AnimButton(
          onClick: control.onLocationClick,
          child: Container(
            color: AppColors.primary20.withAlpha(100),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                SvgIcon(
                  path: "ic_location", size: 12, color: AppColors.primary70,),
                const SizedBox(width: 10,),
                Expanded(child: Text(
                  "Thurpu cheruvu center, veeravasaram, 534245", maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyles.s14Primary705,))
              ],
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              const SizedBox(height: 6,),
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
              ImageLoader(url: dummyImages[1].autoUrl, height: 140,),
              ImageLoader(url: dummyImages[0].autoUrl, height: 140,),
              ImageLoader(url: dummyImages[1].autoUrl, height: 140,),
              ImageLoader(url: dummyImages[0].autoUrl, height: 140,),
              const SizedBox(height: 16,),
            ],
          ),
        ))
      ],
    );
  }
}
