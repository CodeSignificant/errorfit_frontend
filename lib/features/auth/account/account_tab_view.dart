import 'package:error_fit/features/auth/account/account_controller.dart';
import 'package:flutter/material.dart';

class AccountTabView extends StatefulWidget {
  final AccountController control;
  const AccountTabView({super.key, required this.control});

  @override
  State<AccountTabView> createState() => _AccountTabViewState();
}

class _AccountTabViewState extends State<AccountTabView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
