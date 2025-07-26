import 'package:error_fit/config/routes/routers.dart';
import 'package:get/get.dart';

import '../../../core/widgets/my_carousel.dart';
import '../models/category_model.dart';

class HomeSectionController extends GetxController{


  final carouselControl = MyCarouselController();



  void onCategoryClick(CategoryModel model) {
    productsSearchRoute.queryParam("category", model.title).navigate;
  }
}