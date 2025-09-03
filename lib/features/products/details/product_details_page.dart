import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/products/details/product_details_control.dart';
import 'package:error_fit/features/products/details/product_details_mobile.dart';
import 'package:error_fit/features/products/details/product_details_web.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final String id;

  const ProductDetailsPage({super.key, required this.id});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final control = ProductDetailsControl();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      control.init(widget.id);
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: ProductDetailsMobile(control: control),
        web: ProductDetailsWeb(control: control),
      ),
    );
  }

}
