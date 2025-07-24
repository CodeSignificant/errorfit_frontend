import 'package:flutter/material.dart';

import 'app_colors.dart';

class Decorations {

  //
  // static BoxDecoration get primaryDot {
  //   return BoxDecoration(
  //     color: AppColors.primary,
  //     shape: BoxShape.circle
  //   );
  // }
  //
  // static BoxDecoration get greenDot {
  //   return BoxDecoration(
  //     color: AppColors.green,
  //     shape: BoxShape.circle
  //   );
  // }
  //
  // static BoxDecoration get addCardBg {
  //   return BoxDecoration(
  //     color: AppColors.black.withAlpha(25),
  //     borderRadius: BorderRadius.circular(15),
  //   );
  // }
  //
  // // static BoxDecoration get gradient {
  // //   return BoxDecoration(
  // //     gradient: LinearGradient(
  // //       colors: [AppColors.g1, AppColors.g2],
  // //       begin: Alignment.bottomLeft,
  // //       end: Alignment.topRight,
  // //     ),
  // //   );
  // // }
  //
  // static BoxDecoration get gradientYellow {
  //   return BoxDecoration(
  //     gradient: LinearGradient(
  //       colors: [Color(0x80530728), Color(0x80ff4d01), ],
  //       begin: Alignment.bottomLeft,
  //       end: Alignment.topRight,
  //     ),
  //   );
  // }
  //
  // // static BoxDecoration get gradient2 {
  // //   return BoxDecoration(
  // //     gradient: LinearGradient(
  // //       colors: [AppColors.g3, AppColors.g4],
  // //       begin: Alignment.bottomLeft,
  // //       end: Alignment.topRight,
  // //     ),
  // //   );
  // // }
  //
  // static BoxDecoration get gradient3 {
  //   return BoxDecoration(
  //     gradient: LinearGradient(
  //       colors: [ Color(0xffae0134), Color(0xff20051a),],
  //       begin: Alignment.topRight,
  //       end: Alignment.bottomLeft,
  //     ),
  //   );
  // }
  //
  static BoxDecoration get card {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.black.withAlpha(20),
          offset: Offset(2, 0),
          spreadRadius: 1,
          blurRadius: 2,
        ),
      ],
    );
  }
  // static BoxDecoration get greyChip {
  //   return BoxDecoration(
  //     color: AppColors.lightGrey,
  //     borderRadius: BorderRadius.circular(16),
  //     boxShadow: const [
  //       BoxShadow(
  //         color: AppColors.light,
  //         offset: Offset(1, 0),
  //         spreadRadius: 1,
  //         blurRadius: 2,
  //       ),
  //     ],
  //   );
  // }
  //
  // static BoxDecoration get greenChip {
  //   return BoxDecoration(
  //     color: AppColors.green,
  //     borderRadius: BorderRadius.circular(48),
  //   );
  // }
  //
  // static BoxDecoration get blackChip {
  //   return BoxDecoration(
  //     color: AppColors.black,
  //     borderRadius: BorderRadius.circular(48),
  //   );
  // }
  // // static BoxDecoration get orangeChip {
  // //   return BoxDecoration(
  // //     color: AppColors.g4,
  // //     borderRadius: BorderRadius.circular(48),
  // //   );
  // // }
  // static BoxDecoration get primaryChip {
  //   return BoxDecoration(
  //     color: AppColors.primary,
  //     borderRadius: BorderRadius.circular(48),
  //   );
  // }
  //
  // static BoxDecoration get gradientWhite {
  //   return BoxDecoration(
  //     gradient: const LinearGradient(
  //       begin: Alignment.topLeft,
  //       end: Alignment.bottomRight,
  //       colors: [
  //         Colors.white, // top-left
  //         Colors.white, // top-right
  //         Colors.white, // bottom-left
  //         Color(0xFFFFEEF2), // bottom-right soft pink
  //       ],
  //       stops: [0.4, 0.4, 0.4, 1],
  //     ),
  //     boxShadow: const [
  //       BoxShadow(
  //         color: AppColors.light,
  //         offset: Offset(4, 0),
  //         spreadRadius: 1,
  //         blurRadius: 7,
  //       ),
  //     ],
  //     borderRadius: BorderRadius.circular(8),
  //   );
  // }
  //
  // static BoxDecoration get yellowBorderPink {
  //   return BoxDecoration(
  //
  //     border: Border.all(color: Color(0xfffffbeb), width: 2),
  //     gradient: const LinearGradient(
  //       begin: Alignment.topLeft,
  //       end: Alignment.bottomRight,
  //       colors: [
  //         Colors.white, // top-left
  //         Colors.white, // top-right
  //         Colors.white, // bottom-left
  //         Color(0xFFFFEEF2), // bottom-right soft pink
  //       ],
  //       stops: [0.4, 0.4, 0.4, 1],
  //     ),
  //     // boxShadow: const [
  //     //   BoxShadow(
  //     //     color: AppColors.light,
  //     //     offset: Offset(4, 0),
  //     //     spreadRadius: 1,
  //     //     blurRadius: 7,
  //     //   ),
  //     // ],
  //     borderRadius: BorderRadius.circular(16),
  //   );
  // }
  //
  // static BoxDecoration get bgBlack40 {
  //   return BoxDecoration(
  //     color: AppColors.black.withAlpha(40),
  //     borderRadius: BorderRadius.circular(10),
  //   );
  // }
  //
  // static BoxDecoration get yellowBorderCard {
  //   return BoxDecoration(
  //     color: AppColors.white,
  //     border: Border.all(color: Color(0xfffffbeb), width: 2),
  //     borderRadius: BorderRadius.circular(16),
  //     boxShadow: [
  //       BoxShadow(
  //         color: AppColors.light.withAlpha(10),
  //         offset: Offset(4, 0),
  //         spreadRadius: 1,
  //         blurRadius: 7,
  //       ),
  //     ],
  //   );
  // }
  //
  // static BoxDecoration get primaryBorderCard {
  //   return BoxDecoration(
  //     color: AppColors.white,
  //     border: Border.all(color: AppColors.primary, width: 2),
  //     borderRadius: BorderRadius.circular(16),
  //     boxShadow: [
  //       BoxShadow(
  //         color: AppColors.light.withAlpha(10),
  //         offset: Offset(4, 0),
  //         spreadRadius: 1,
  //         blurRadius: 7,
  //       ),
  //     ],
  //   );
  // }
  //
  // // static BoxDecoration get gradient2BorderCard {
  // //   return BoxDecoration(
  // //     color: AppColors.white,
  // //     border: Border.all(color: AppColors.g2, width: 2),
  // //     borderRadius: BorderRadius.circular(16),
  // //     gradient: LinearGradient(colors: [
  // //       AppColors.white, AppColors.bgRed
  // //     ], begin: Alignment.topLeft, end: Alignment.bottomRight),
  // //     boxShadow: [
  // //       BoxShadow(
  // //         color: AppColors.light.withAlpha(10),
  // //         offset: Offset(4, 0),
  // //         spreadRadius: 1,
  // //         blurRadius: 7,
  // //       ),
  // //     ],
  // //   );
  // // }
  //
  // static BoxDecoration get greenBorderCard {
  //   return BoxDecoration(
  //     color: AppColors.white,
  //     border: Border.all(color: AppColors.green, width: 2),
  //     borderRadius: BorderRadius.circular(16),
  //     boxShadow: [
  //       BoxShadow(
  //         color: AppColors.light.withAlpha(10),
  //         offset: Offset(4, 0),
  //         spreadRadius: 1,
  //         blurRadius: 7,
  //       ),
  //     ],
  //   );
  // }
  //
  // static BoxDecoration get greyBorderCard {
  //   return BoxDecoration(
  //     color: AppColors.white,
  //     border: Border.all(color: AppColors.greenLight, width: 2),
  //     borderRadius: BorderRadius.circular(16),
  //     boxShadow: [
  //       BoxShadow(
  //         color: AppColors.light.withAlpha(10),
  //         offset: Offset(4, 0),
  //         spreadRadius: 1,
  //         blurRadius: 7,
  //       ),
  //     ],
  //   );
  // }
  //
  // static BoxDecoration get grey {
  //   return BoxDecoration(
  //     color: Color(0xfff5f5f5),
  //     borderRadius: BorderRadius.circular(20),
  //   );
  // }
  //
  // static BoxDecoration get yellowCard {
  //   return BoxDecoration(
  //     color: Color(0xfffff9d1),
  //     borderRadius: BorderRadius.circular(8),
  //     boxShadow: [
  //       BoxShadow(
  //         color: Colors.black.withAlpha(7),
  //         offset: Offset(2, 0),
  //         spreadRadius: 2,
  //         blurRadius: 2,
  //       ),
  //     ],
  //   );
  // }
  //
  // static BoxDecoration get yellowRoundCard {
  //   return BoxDecoration(
  //     color: Color(0xfffbd78a),
  //     borderRadius: BorderRadius.circular(100),
  //     // boxShadow: [
  //     //   BoxShadow(
  //     //     color: Colors.black.withAlpha(7),
  //     //     offset: Offset(2, 0),
  //     //     spreadRadius: 2,
  //     //     blurRadius: 2,
  //     //   ),
  //     // ],
  //   );
  // }
  //
  // static BoxDecoration get whiteRoundCard {
  //   return BoxDecoration(
  //     color:AppColors.white,
  //     borderRadius: BorderRadius.circular(100),
  //     // boxShadow: [
  //     //   BoxShadow(
  //     //     color: Colors.black.withAlpha(7),
  //     //     offset: Offset(2, 0),
  //     //     spreadRadius: 2,
  //     //     blurRadius: 2,
  //     //   ),
  //     // ],
  //   );
  // }
  //
  // static BoxDecoration get bgRoundCard {
  //   return BoxDecoration(
  //     color: Color(0xfffbeacf),
  //     borderRadius: BorderRadius.circular(100),
  //     // boxShadow: [
  //     //   BoxShadow(
  //     //     color: Colors.black.withAlpha(7),
  //     //     offset: Offset(2, 0),
  //     //     spreadRadius: 2,
  //     //     blurRadius: 2,
  //     //   ),
  //     // ],
  //   );
  // }
  //
  // static BoxDecoration get bottomLine {
  //   return BoxDecoration(
  //     color: AppColors.white, // Background color
  //     boxShadow: [
  //       BoxShadow(
  //         color: AppColors.light.withAlpha(70),
  //         blurRadius: 4.0,
  //         spreadRadius: 0.0,
  //         offset: const Offset(0, 4),
  //       ),
  //     ],
  //   );
  // }
  //
  // static BoxDecoration get bottomSheet {
  //   return BoxDecoration(
  //     color: Colors.white,
  //     borderRadius: BorderRadius.only(
  //       topRight: Radius.circular(16),
  //       topLeft: Radius.circular(16),
  //     ),
  //   );
  // }
  //
  // static BoxDecoration get outline {
  //   return BoxDecoration(
  //     color: AppColors.primary,
  //     border: Border.all(color: AppColors.white, width: 2),
  //     borderRadius: BorderRadius.circular(48),
  //   );
  // }
}
