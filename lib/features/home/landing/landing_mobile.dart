import 'package:error_fit/config/environments/config.dart';
import 'package:error_fit/config/styles/app_colors.dart';
import 'package:error_fit/core/images/ImageLoader.dart';
import 'package:error_fit/core/resources/constants.dart';
import 'package:error_fit/features/home/landing/landing_controller.dart';
import 'package:error_fit/features/home/widgets/login_types_row.dart';
import 'package:flutter/material.dart';

import '../../../core/widgets/my_carousel.dart';

class LandingMobile extends StatefulWidget {
  final LandingController control;
  const LandingMobile({super.key, required this.control});

  @override
  State<LandingMobile> createState() => _LandingMobileState();
}

class _LandingMobileState extends State<LandingMobile> {


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: MyCarousel(
                  control: widget.control.carouselControl,
                  autoScrollDuration: Duration(seconds: 4),
                  items: [
                    ImageLoader(
                        url: "https://${Config.domain}${dummyImages[0]}"),
                    ImageLoader(
                        url: "https://${Config.domain}${dummyImages[0]}"),
                    ImageLoader(
                        url: "https://${Config.domain}${dummyImages[0]}"),
                  ],
                ),
              ),
              Positioned(left: 0, right: 0, bottom: 0, child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.transparent,
                      AppColors.white
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 48,),
                    DotListener(
                      control: widget.control.carouselControl,
                      builder: (index, length, goToPage) =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(length, (i) =>
                                Container(
                                  width: 42,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(48),
                                      color: index == i
                                          ? AppColors.white
                                          : AppColors.primary70
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 8),
                                )
                              // Text(" O ",
                              //   style: TextStyle(color: index == i ? Colors
                              //       .white : Colors.black),),
                            ),
                          ),),
                    const SizedBox(height: 6,),
                    LoginTypesRow(onSelect: widget.control.onLoginTypeSelect),
                    const SizedBox(height: 16,),

                  ],
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }
}
