import 'package:error_fit/config/styles/break_points.dart';
import 'package:flutter/widgets.dart';

extension RatioExtension on num {
  /// Scales the current number proportionally between minTarget and maxTarget
  /// based on the current screen width in the range [minScreenWidth, maxScreenWidth].
  double ratio(BuildContext context, double minTarget, double maxTarget) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Clamp the screen width within the screen range
    final clampedWidth = screenWidth.clamp(minScreen, maxScreen);

    // Calculate interpolation ratio between minScreenWidth and maxScreenWidth
    final ratio = (clampedWidth - minScreen) / (maxScreen - minScreen);

    // Map ratio linearly from minTarget to maxTarget
    return minTarget + ratio * (maxTarget - minTarget);
  }
}
