import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/address/main/address_controller.dart';
import 'package:error_fit/features/address/main/address_mobile_view.dart';
import 'package:error_fit/features/address/main/address_tab_view.dart';
import 'package:error_fit/features/address/main/address_web_view.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final control = AddressController();

  @override
  void initState() {
    control.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: AddressMobileView(control: control),
        tab: AddressTabView(control: control),
        web: AddressWebView(control: control),
      ),
    );
  }
}
