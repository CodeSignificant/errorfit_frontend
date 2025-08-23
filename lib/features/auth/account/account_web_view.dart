import 'package:error_fit/features/auth/account/account_controller.dart';
import 'package:flutter/material.dart';

class AccountWebView extends StatefulWidget {
  final AccountController control;

  const AccountWebView({super.key, required this.control});

  @override
  State<AccountWebView> createState() => _AccountWebViewState();
}

class _AccountWebViewState extends State<AccountWebView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
