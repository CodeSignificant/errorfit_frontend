import 'package:error_fit/features/address/main/address_controller.dart';
import 'package:flutter/material.dart';

class AddressTabView extends StatefulWidget {
  final AddressController control;

  const AddressTabView({super.key, required this.control});

  @override
  State<AddressTabView> createState() => _AddressTabViewState();
}

class _AddressTabViewState extends State<AddressTabView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
