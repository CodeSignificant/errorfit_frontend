import 'package:error_fit/core/resources/screen_view.dart';
import 'package:error_fit/features/auth/account/account_controller.dart';
import 'package:error_fit/features/auth/account/account_mobile_view.dart';
import 'package:error_fit/features/auth/account/account_tab_view.dart';
import 'package:error_fit/features/auth/account/account_web_view.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final control = AccountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenView(
        mobile: AccountMobileView(control: control),
        tab: AccountTabView(control: control),
        web: AccountWebView(control: control),
      ),
    );
  }
}
