import 'package:error_fit/core/app_bars/toast.dart';
import 'package:error_fit/core/network/repo/users/wishlist_repo.dart';
import 'package:error_fit/core/resources/data_response.dart';
import 'package:error_fit/core/resources/pagination.dart';
import 'package:error_fit/core/widgets/loading_view.dart';
import 'package:error_fit/features/products/models/product_model.dart';
import 'package:get/get.dart';

import '../../../config/routes/routers.dart';
import '../../../config/services/auth.dart';

class WishlistController extends GetxController {
  final loadingControl = LoadingViewController();
  final pagination = Pagination();

  @override
  void onInit() {
    _loadLikedProducts();
    super.onInit();
  }

  void _loadLikedProducts() async {
    Pagination.listener(
      controller: pagination,
      onInitialLoad: () async {
        final result = await WishlistRepo.fetch();
        loadingControl.setLoading(false);
        if (result is DataSuccess) return result.data!;
        return null;
      },
      onFetch: (nextPage) async {
        final result = await WishlistRepo.fetch(page: nextPage);
        if (result is DataSuccess) return result.data!;
        return null;
      },
    );

    // final result = await WishlistRepo.fetch();
    // if (result is DataSuccess) {
    //   productsList.addAll(result.data!);
    //   if (productsList.isEmpty) {
    //     loadingControl.setError("No Liked Products Found");
    //     return;
    //   }
    //   loadingControl.setLoading(false);
    //   return;
    // }
    // if (result is DataFailed) {
    //   loadingControl.setError(result.error);
    //   Toast.failed(title: "Unable to fetch", message: result.error);
    //   return;
    // }
  }

  onProductClick(ProductModel model) {
    productDetailsRoute.param(model.id).navigate;
  }

  onProductLikeClick(ProductModel model) async {
    if (!Auth.isLogin) {
      landingRoute.navigate;
      return;
    }
    pagination.items.remove(model);
    if (pagination.items.isEmpty) {
      loadingControl.setError("No Liked Products Found");
    }
    await WishlistRepo.setLike(productId: model.id, like: false);
  }
}
