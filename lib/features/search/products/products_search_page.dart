
import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/search/products/product_search_web_view.dart';
import 'package:error_fit/features/search/products/products_search_control.dart';
import 'package:error_fit/features/search/products/products_search_mobile.dart';
import 'package:flutter/material.dart';

class ProductsSearchPage extends StatefulWidget {
  final Map<String, String?> queryParams;
  const ProductsSearchPage({super.key, required this.queryParams});

  @override
  State<ProductsSearchPage> createState() => _ProductsSearchPageState();
}

class _ProductsSearchPageState extends State<ProductsSearchPage> {
  final control = ProductsSearchControl();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      control.init(widget.queryParams);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: ProductsSearchMobile(control: control),
        web: ProductSearchWebView(control: control),
      ),
    );
  }
}
